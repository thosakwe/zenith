// GENERATED CODE. Do not modify by hand.

import 'dart:web_gl';
import 'package:zenith_html/zenith_html.dart';

/// Asset generated from package:zenith_html/src/objects/plane.fragment.glsl.
final PlaneFragmentGLSL planeFragmentShader = new PlaneFragmentGLSL._();

/// Asset generated from package:zenith_html/src/objects/plane.fragment.glsl.
class PlaneFragmentGLSL extends GLSL {
  PlaneFragmentGLSL._() : super('''varying lowp vec4 vColor;

void main(void) {
    //gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);//vColor;
    gl_FragColor = vColor;
}''', FRAGMENT_SHADER);
}
