import 'package:vector_math/vector_math.dart';

import 'drawable.dart';

abstract class Plane2D extends MonochromeDrawable {
  Plane2D(Vector3 position, Vector3 size, Vector4 color) : super(position, size, color);
}