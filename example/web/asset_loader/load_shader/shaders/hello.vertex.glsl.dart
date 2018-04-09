// GENERATED CODE. Do not modify by hand.

import 'dart:web_gl';
import 'package:zenith_html/zenith_html.dart';

/// Asset generated from asset:example/web/asset_loader/load_shader/shaders/hello.vertex.glsl.
final HelloVertexGLSL helloVertexShader = new HelloVertexGLSL._();

/// Asset generated from asset:example/web/asset_loader/load_shader/shaders/hello.vertex.glsl.
class HelloVertexGLSL extends GLSL {
  HelloVertexGLSL._() : super('''attribute vec4 aVertexPosition;
attribute vec4 aVertexColor;
uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
varying lowp vec4 vColor;

void main(void) {
    gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;
    vColor = aVertexColor;
}''', FRAGMENT_SHADER);

  int _aVertexPosition;

  int _aVertexColor;

  UniformLocation _uModelViewMatrix;

  UniformLocation _uProjectionMatrix;

  /// Gets the location of the attribute `aVertexPosition` within the [program].
  int get aVertexPosition {
    return _aVertexPosition ??=
        context.getAttribLocation(program, 'aVertexPosition');
  }

  /// Gets the location of the attribute `aVertexColor` within the [program].
  int get aVertexColor {
    return _aVertexColor ??= context.getAttribLocation(program, 'aVertexColor');
  }

  /// Gets the location of the uniform `uModelViewMatrix` within the [program].
  UniformLocation get uModelViewMatrix {
    return _uModelViewMatrix ??=
        context.getUniformLocation(program, 'uModelViewMatrix');
  }

  /// Gets the location of the uniform `uProjectionMatrix` within the [program].
  UniformLocation get uProjectionMatrix {
    return _uProjectionMatrix ??=
        context.getUniformLocation(program, 'uProjectionMatrix');
  }
}
