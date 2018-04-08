import 'dart:web_gl';
import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart';
import '../game.dart';

class WebGLPlane extends Plane2D {
  final HtmlGame game;

  WebGLPlane(this.game, Vector3 position, Vector3 size, Vector4 color)
      : super(position, size, color);

  @override
  void draw(Game game, World world) {
    // TODO: implement draw
  }
}
