// GENERATED CODE. Do not modify by hand.

import 'dart:web_gl';
import 'package:zenith_html/zenith_html.dart';

/// Asset generated from asset:example/web/asset_loader/load_shader/shaders/hello.fragment.glsl.
final HelloFragmentGLSL helloFragmentShader = new HelloFragmentGLSL._();

/// Asset generated from asset:example/web/asset_loader/load_shader/shaders/hello.fragment.glsl.
class HelloFragmentGLSL extends GLSL {
  HelloFragmentGLSL._() : super('''varying lowp vec4 vColor;

void main(void) {
    gl_FragColor = vColor;
}''', FRAGMENT_SHADER);
}
