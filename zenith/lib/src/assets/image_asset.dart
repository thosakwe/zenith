import 'package:async/async.dart';
import 'package:image/image.dart';
import 'asset.dart';
import 'asset_loader.dart';

/// An [Asset] that asynchronously loads an [Image].
class ImageAsset extends Asset<Image> {
  final String url;

  ImageAsset(this.url);

  @override
  CancelableOperation<Image> loadFresh(AssetLoader loader) {
    var op = loader.loadBytes(url);
    var c = new CancelableCompleter<Image>(onCancel: op.cancel);
    c.complete(op.value.then(decodeImage));
    return c.operation;
  }
}