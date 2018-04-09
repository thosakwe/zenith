import 'dart:html' show CanvasElement;
import 'dart:web_gl';

import 'package:vector_math/vector_math.dart' hide Plane;
import 'package:zenith/zenith.dart';
import 'objects/objects.dart';
import 'game.dart';

/// A [World] implementation that uses WebGL to draw to the screen.
class WebGLWorld extends World {
  final CanvasElement canvas;
  final HtmlGame game;

  @override
  Vector3 size;

  _WebGLPerspectiveCamera _camera;
  Program _program;

  final List<Drawable> _objects = [];
  RenderingContext context;

  WebGLWorld(this.canvas, this.game) {
    _camera = new _WebGLPerspectiveCamera(this);
    context = canvas.getContext3d();
    size = new Vector3(canvas.width.toDouble(), canvas.height.toDouble(),
        canvas.width.toDouble());
  }

  @override
  Camera get camera => _camera;

  /// The WebGL [Program] for this frame.
  Program get program => _program;

  /// Draws the current game contents.
  void render() {
    context.viewport(0, 0, canvas.width, canvas.height);
    _program = context.createProgram();

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
      ..clear(COLOR_BUFFER_BIT | DEPTH_BUFFER_BIT)
      ..clearDepth(1.0)
      ..enable(DEPTH_TEST)
      ..depthFunc(LEQUAL);
  }

  @override
  Plane createPlane(Vector3 position, Vector3 size, Vector4 color) {
    var plane = new WebGLPlane(
      game,
      new Matrix4.identity()..transform3(position),
      new Matrix4.zero()..transform3(size),
      color,
    );
    _objects.add(plane);
    return plane;
  }
}

class _WebGLPerspectiveCamera extends PerspectiveCamera {
  final WebGLWorld world;

  _WebGLPerspectiveCamera(this.world) : super();

  @override
  num get aspectRatio => world.canvas.clientWidth / world.canvas.clientHeight;
}
