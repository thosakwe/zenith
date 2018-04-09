import 'dart:async';
import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart';

final BootScene bootScene = new BootScene._();

class BootScene extends Scene {
  BootScene._();

  @override
  Future create(Game game) {
    game.world.createPlane(
      new Vector3.zero(),
      new Vector3.all(100.0),
      Colors.fuchsia,
    );
    return super.create(game);
  }

  @override
  Future update(Game game) async {
    await super.update(game);
    game.world.clear(Colors.black);
  }
}
