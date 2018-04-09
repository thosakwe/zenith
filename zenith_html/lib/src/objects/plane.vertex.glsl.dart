// GENERATED CODE. Do not modify by hand.

import 'dart:web_gl';
import 'package:zenith_html/zenith_html.dart';

/// Asset generated from package:zenith_html/src/objects/plane.vertex.glsl.
final PlaneVertexGLSL planeVertexShader = new PlaneVertexGLSL._();

/// Asset generated from package:zenith_html/src/objects/plane.vertex.glsl.
class PlaneVertexGLSL extends GLSL {
  PlaneVertexGLSL._() : super('''attribute vec4 aVertexPosition;
attribute vec4 aVertexColor;
uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
varying lowp vec4 vColor;

void main(void) {
    gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;
    vColor = aVertexColor;
}''', VERTEX_SHADER);

  /// Gets the location of the attribute `aVertexPosition` within the [program].
  int get aVertexPosition {
    return context.getAttribLocation(program, 'aVertexPosition');
  }

  /// Gets the location of the attribute `aVertexColor` within the [program].
  int get aVertexColor {
    return context.getAttribLocation(program, 'aVertexColor');
  }

  /// Gets the location of the uniform `uModelViewMatrix` within the [program].
  UniformLocation get uModelViewMatrix {
    return context.getUniformLocation(program, 'uModelViewMatrix');
  }

  /// Gets the location of the uniform `uProjectionMatrix` within the [program].
  UniformLocation get uProjectionMatrix {
    return context.getUniformLocation(program, 'uProjectionMatrix');
  }
}
