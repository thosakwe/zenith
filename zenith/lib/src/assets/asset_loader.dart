import 'dart:async';
import 'dart:collection';
import 'package:async/async.dart';
import 'package:image/image.dart';
import 'asset.dart';

/// An interface for asynchronously loading assets.
abstract class AssetLoader {
  /// A [Map] of miscellaneous assets to be loaded.
  ///
  /// Prefer using one of the typed alternatives:
  /// * [images]
  final Map<String, Asset> assets = {};

  /// A [Map] of images to be loaded.
  final Map<String, Asset<Image>> images = {};

  /// Loads a byte array.
  CancelableOperation<List<int>> loadBytes();

  /// Loads a string.
  CancelableOperation<String> loadString();

  /// Loads a JSON document.
  CancelableOperation<T> loadJSON<T>();

  /// Loads all assets asynchronously. Can be cancelled.
  CancelableOperation loadAllAssets() {
    var completer = new CancelableCompleter();
    var queue = new Queue<Asset>()
      ..addAll(assets.values)
      ..addAll(images.values);

    scheduleMicrotask(() async {
      while (queue.isNotEmpty && !completer.isCanceled) {
        await queue.removeFirst().load(this);
      }

      if (!completer.isCanceled) completer.complete();
    });

    return completer.operation;
  }
}
