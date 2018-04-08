import 'dart:async';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

/// [ImageAssetBuilder] factory.
Builder imageAssetBuilder(_) => const ImageAssetBuilder();

/// Generates an `Asset<Image>` that loads the contents of the given file from an in-memory array, rather than XHR.
class ImageAssetBuilder implements Builder {
  const ImageAssetBuilder();

  static const String extension = '.asset.dart';

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      '.png': [extension],
      '.jpg': [extension],
      '.jpeg': [extension],
      '.tiff': [extension],
      '.psd': [extension],
      '.tga': [extension],
      '.webp': [extension],
      '.gif': [extension],
    };
  }

  @override
  Future build(BuildStep buildStep) async {
    var byteArray = await buildStep.readAsBytes(buildStep.inputId);
    var suffix = p.extension(buildStep.inputId.uri.path).substring(1);
    suffix = suffix[0].toUpperCase() + suffix.substring(1);

    var lib = new Library((b) {
      b.directives.addAll([
        new Directive.import('dart:async'),
        new Directive.import('package:async/async.dart'),
        new Directive.import('package:image/image.dart'),
        new Directive.import('package:zenith/zenith.dart'),
      ]);

      b.body.add(new Code('// GENERATED CODE. Do not modify by hand.'));

      b.body.add(new Class((b) {
        b.name = new ReCase(p.basenameWithoutExtension(buildStep.inputId.path))
                .pascalCase +
            'Asset';

        b.implements.add(new TypeReference((b) {
          b
            ..symbol = 'Asset'
            ..types.add(new Reference('Image'));
        }));

        b.constructors.add(new Constructor((b) => b..constant = true));

        b.methods.add(new Method((b) {
          b
            ..name = 'loadFresh'
            ..annotations.add(new CodeExpression(new Code('override')))
            ..requiredParameters.add(new Parameter((b) {
              b
                ..name = 'loader'
                ..type = new Reference('AssetLoader');
            }))
            ..body = new Code('''
          return new CancelableOperation<Image>.fromFuture(
            new Future<Image>.value(
              decode$suffix(
                const $byteArray
              )
            )
          );
          ''');
        }));
      }));
    });

    var buf = lib.accept(new DartEmitter());
    var formatted = new DartFormatter().format(buf.toString());
    buildStep.writeAsString(
        buildStep.inputId.changeExtension(extension), formatted);
  }
}
