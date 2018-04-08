import 'dart:async';
import 'package:image/image.dart';
import 'package:zenith/zenith.dart';
import '../../assets/dart-logo.png.asset.dart';

main() {
  Game game;
}

final BootScene bootScene = new BootScene._();

class BootScene extends Scene {
  Asset<Image> xhrDartLogoAsset;

  BootScene._();

  @override
  Future load(Game game) {
    // We can use the auto-generated asset from 'dart-logo.png.asset.dart' for better speed.
    game.assetLoader.assets.add(dartLogoAsset);

    // However, we can also load from XHR.
    xhrDartLogoAsset = Asset.image('../../assets/dart-logo.png');
    game.assetLoader.assets.add(xhrDartLogoAsset);

    return super.load(game);
  }
}