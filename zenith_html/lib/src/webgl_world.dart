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
  Vector3 size;

  final List<Drawable> _objects = [];
  RenderingContext _context;

  WebGLWorld(this.canvas, this.game) {
    _context = canvas.getContext3d();
    size = new Vector3(canvas.width.toDouble(), canvas.height.toDouble(),
        canvas.width.toDouble());
  }

  @override
  void clear(Vector4 color) {
    _context
      ..clearColor(color.r, color.g, color.b, color.a)
      ..clear(COLOR_BUFFER_BIT);
  }

  @override
  Cube createCube(Vector3 position, Vector3 size, Vector4 color) {
    var cube = new WebGLCube(game, position, size, color);
    _objects.add(cube);
    return cube;
  }
}
