import 'dart:async';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:image/image.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

/// Generates an `Asset<Image>` that loads the contents of the given file from memory, rather than XHR.
class ImageAssetBuilder implements Builder {
  const ImageAssetBuilder();

  static const String extension = '.asset.dart';

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      '.png': ['.png' + extension],
      '.jpg': ['.jpg' + extension],
      '.jpeg': ['.jpeg' + extension],
      '.tiff': ['.tiff' + extension],
      '.psd': ['.psd' + extension],
      '.tga': ['.tga' + extension],
      '.webp': ['.webp' + extension],
      '.gif': ['.gif' + extension],
    };
  }

  @override
  Future build(BuildStep buildStep) async {
    var image = decodeImage(await buildStep.readAsBytes(buildStep.inputId));

    var lib = new Library((b) {
      var className =
          new ReCase(p.basenameWithoutExtension(buildStep.inputId.path))
                  .pascalCase +
              'Asset';
      var rc = new ReCase(className);

      b.directives.addAll([
        new Directive.import('dart:async'),
        new Directive.import('package:async/async.dart'),
        new Directive.import('package:image/image.dart'),
        new Directive.import('package:zenith/zenith.dart'),
      ]);

      b.body.add(
          new Code('/// Asset generated from ${buildStep.inputId.uri}.\n'));

      b.body.add(
          new Code('final Asset<Image> ${rc.camelCase} = new _$className();'));

      b.body.add(new Class((b) {
        b.name = '_' + className;

        b.extend = new TypeReference((b) {
          b
            ..symbol = 'Asset'
            ..types.add(new Reference('Image'));
        });

        b.methods.add(new Method((b) {
          var buf = new StringBuffer();

          for (int x = 0; x < image.width; x++) {
            for (int y = 0; y < image.width; y++) {
              var pixel = image.getPixel(x, y);
              buf.writeln('image.setPixel($x, $y, $pixel);');
            }
          }

          b
            ..name = 'loadFresh'
            ..annotations.add(new CodeExpression(new Code('override')))
            ..requiredParameters.add(new Parameter((b) {
              b
                ..name = 'loader'
                ..type = new Reference('AssetLoader');
            }))
            ..body = new Code('''
          var image = new Image(${image.width}, ${image.height});
          $buf
          return new CancelableOperation<Image>.fromFuture(
            new Future<Image>.value(image)
          );
          ''');
        }));
      }));
    });

    var buf = lib.accept(new DartEmitter());
    var formatted = '// GENERATED CODE. Do not modify by hand.\n\n' +
        new DartFormatter().format(buf.toString());
    buildStep.writeAsString(
        buildStep.inputId
            .changeExtension(buildStep.inputId.extension + extension),
        formatted);
  }
}
