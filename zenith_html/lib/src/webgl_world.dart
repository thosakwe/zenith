import 'dart:html' show CanvasElement, RenderingContext2D;
import 'dart:web_gl';

import 'package:zenith/zenith.dart';

/// A [World] implementation that uses WebGL to draw to the screen.
class WebGLWorld extends World {
  final CanvasElement canvas;

  WebGLWorld(this.canvas);

  @override
  void clear(color) {
    // TODO: implement clear
  }
}