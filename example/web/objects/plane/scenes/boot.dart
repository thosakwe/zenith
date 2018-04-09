import 'dart:async';
import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart' as z;

final BootScene bootScene = new BootScene._();

class BootScene extends z.Scene {
  bool add = true;
  z.Plane plane;

  BootScene._();

  @override
  Future create(z.Game game) {
    plane = game.world.createPlane(
      new Vector3.zero(),
      new Vector3.all(100.0),
      Colors.fuchsia,
    );
    return super.create(game);
  }

  @override
  Future update(z.Game game) async {
    await super.update(game);
    game.world.clear(Colors.black);
    plane.transform.rotate = new Vector3(0.0, 0.0, 1 / 90);
  }
}