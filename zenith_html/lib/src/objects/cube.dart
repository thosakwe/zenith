import 'dart:web_gl';
import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart';
import '../game.dart';

class WebGLCube extends Cube {
  final HtmlGame game;

  WebGLCube(this.game, Vector3 position, Vector3 size, Vector4 color)
      : super(position, size, color);

  @override
  void draw(Game game, World world) {
    // TODO: implement draw
  }
}
