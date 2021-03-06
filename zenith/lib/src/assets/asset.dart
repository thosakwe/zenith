import 'dart:async';
import 'package:async/async.dart';
import 'package:image/image.dart';
import 'asset_loader.dart';
import 'image_asset.dart';

/// A piece of data produced by an expensive computation.
///
/// Internally, this class performs memoization to ensure
/// that the computation only is ever run once.
abstract class Asset<T> {
  T _value;

  /// Creates an [Asset] that asynchronously loads an [Image].
  static Asset<Image> image(String url) => new ImageAsset(url);

  /// The current value of this asset.
  ///
  /// This will be `null` if [load] has not been called.
  T get value => _value;

  /// Gets the value of this asset, either through computation or a memoized value.
  CancelableOperation<T> load(AssetLoader loader) {
    if (_value != null) {
      return new CancelableOperation.fromFuture(new Future.value(_value));
    }

    var fresh = loadFresh(loader);
    var c = new CancelableCompleter<T>(onCancel: fresh.cancel);
    c.complete(fresh.value.then((value) {
      _value = value;
    }));
    return c.operation;
  }

  /// Loads the value. This is the function called by the memoizer.
  CancelableOperation<T> loadFresh(AssetLoader loader);
}
