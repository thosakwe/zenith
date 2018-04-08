import 'dart:async';
import 'dart:collection';
import 'package:async/async.dart';
import 'asset.dart';

/// An interface for asynchronously loading assets.
abstract class AssetLoader {
  /// A [List] of images to be loaded.
  final List<Asset> assets = [];

  /// Loads a byte array.
  CancelableOperation<List<int>> loadBytes(String url);

  /// Loads a string.
  CancelableOperation<String> loadString(String url);

  /// Loads a JSON document.
  CancelableOperation<T> loadJSON<T>(String url);

  /// Loads all assets asynchronously. Can be cancelled.
  CancelableOperation loadAllAssets() {
    var completer = new CancelableCompleter();
    var queue = new Queue<Asset>.from(assets);

    scheduleMicrotask(() async {
      while (queue.isNotEmpty && !completer.isCanceled) {
        await queue.removeFirst().load(this).value;
      }

      if (!completer.isCanceled) completer.complete();
    });

    return completer.operation;
  }
}
