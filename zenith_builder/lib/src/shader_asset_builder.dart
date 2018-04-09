import 'dart:async';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:recase/recase.dart';
import 'package:path/path.dart' as p;

/// Pre-builds .glsl files into convenient `Asset<GLSL>` subclasses.
class ShaderBuilder implements Builder {
  static final RegExp _regex = new RegExp(
      r'(attribute|uniform)\s+[A-Za-z_][A-Za-z0-9_]*\s+([A-Za-z_][A-Za-z0-9_]*)');

  const ShaderBuilder();

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      '.fragment.glsl': ['.fragment.glsl.dart'],
      '.vertex.glsl': ['.vertex.glsl.dart'],
    };
  }

  @override
  Future build(BuildStep buildStep) async {
    var source = await buildStep.readAsString(buildStep.inputId);
    bool isVertex = buildStep.inputId.path.endsWith('.vertex.glsl');
    var rc = new ReCase(p.basenameWithoutExtension(buildStep.inputId.uri.path));

    var lib = new Library((b) {
      b.directives.addAll([
        new Directive.import('dart:web_gl'),
        new Directive.import('package:zenith_html/zenith_html.dart'),
      ]);

      b.body.add(
          new Code('/// Asset generated from ${buildStep.inputId.uri}.\n'));

      var glslClassName = rc.pascalCase + 'GLSL';

      // First, make a `final` instance of the GLSL class.
      b.body.add(new Code('final $glslClassName ${rc
          .camelCase}Shader = new $glslClassName._();'));

      // Next, actually generate the GLSL class.
      b.body.add(
          new Code('/// Asset generated from ${buildStep.inputId.uri}.\n'));

      b.body.add(new Class((b) {
        b
          ..name = glslClassName
          ..extend = new Reference('GLSL');

        // Create a constructor that forwards to super with (source, X_SHADER).
        var shaderType = isVertex ? 'VERTEX_SHADER' : 'FRAGMENT_SHADER';
        b.constructors.add(new Constructor((b) {
          b
            ..name = '_'
            ..initializers.add(new Code("super('''$source''', $shaderType)"));
        }));

        // Now, just create memoized getters for every attribute and uniform.
        for (var match in _regex.allMatches(source)) {
          var isAttribute = match[1] == 'attribute', name = match[2];

          var rc = new ReCase(name);
          var fieldName = rc.camelCase;
          var locationMethod =
              isAttribute ? 'getAttribLocation' : 'getUniformLocation';
          var type = new Reference(isAttribute ? 'int' : 'UniformLocation');
          var doc = isAttribute ? 'attribute' : 'uniform';

          /*
          // Create the private field.
          b.fields.add(new Field((b) {
            b
              ..name = '_' + fieldName
              ..type = type;
          }));
          */

          // Now just add a getter.
          b.methods.add(new Method((b) {
            b
              ..docs.add(
                  '/// Gets the location of the $doc `$name` within the [program].')
              ..name = fieldName
              ..returns = type
              ..type = MethodType.getter
              ..body = new Code(
                  "return context.$locationMethod(program, '$name');");
                  //"return _$fieldName ??= context.$locationMethod(program, '$name');");
          }));
        }
      }));
    });

    var formatted = '// GENERATED CODE. Do not modify by hand.\n\n' +
        new DartFormatter().format(lib.accept(new DartEmitter()).toString());
    buildStep.writeAsString(
        buildStep.inputId
            .changeExtension(buildStep.inputId.extension + '.dart'),
        formatted);
  }
}
