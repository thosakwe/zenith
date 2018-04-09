import 'package:vector_math/vector_math.dart' hide Plane;

import 'drawable.dart';

abstract class Plane extends Drawable {
  Plane(Vector3 position, Vector3 size, Vector4 color) : super(position, size);
}