import 'dart:async';
import 'package:zenith/zenith.dart';
import '../../assets/dart-logo.png.asset.dart';

main() {
  Game game;
}

final BootScene bootScene = new BootScene._();

class BootScene extends Scene {
  BootScene._();

  @override
  Future load(Game game) {
    game.assetLoader.assets.add(dartLogoAsset);
    return super.load(game);
  }
}