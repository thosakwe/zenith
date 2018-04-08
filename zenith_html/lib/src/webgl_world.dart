import 'dart:html' show CanvasElement, RenderingContext;
import 'dart:web_gl';

import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart';
import 'objects/objects.dart';
import 'game.dart';

/// A [World] implementation that uses WebGL to draw to the screen.
class WebGLWorld extends World {
  final CanvasElement canvas;
  final HtmlGame game;
  Program program;
  Vector3 size;

  final List<Drawable> _objects = [];
  RenderingContext context;

  WebGLWorld(this.canvas, this.game) {
    context = canvas.getContext3d();
    size = new Vector3(canvas.width.toDouble(), canvas.height.toDouble(),
        canvas.width.toDouble());
    program = context.createProgram();
  }

  /// Draws the current game contents.
  void render() {
    for (var obj in _objects) {
      obj.draw(game, this);
    }
  }

  @override
  double normalizeX(double x) {
    return x / size.x;
  }

  @override
  double normalizeY(double y) {
    return y / size.y;
  }

  @override
  double normalizeZ(double z) {
    return z / size.z;
  }

  @override
  void clear(Vector4 color) {
    context
      ..clearColor(color.r, color.g, color.b, color.a)
      ..clear(COLOR_BUFFER_BIT);
  }

  @override
  Cube createCube(Vector3 position, Vector3 size, Vector4 color) {
    var cube = new WebGLCube(game, position, size, color);
    _objects.add(cube);
    return cube;
  }

  @override
  Plane2D createPlane(Vector3 position, Vector3 size, Vector4 color) {
    var plane = new WebGLPlane(game, position, size, color);
    _objects.add(plane);
    return plane;
  }
}
