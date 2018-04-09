import 'dart:async';
import 'package:image/image.dart';
import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart';
import '../shaders/hello.fragment.glsl.dart';
import '../shaders/hello.vertex.glsl.dart';

final BootScene bootScene = new BootScene._();

class BootScene extends Scene {

  BootScene._();

  @override
  Future create(Game game) {
    game.world.clear(Colors.cornflowerBlue);
    return super.create(game);
  }

  @override
  Future update(Game game) async {
    await super.update(game);
  }
}