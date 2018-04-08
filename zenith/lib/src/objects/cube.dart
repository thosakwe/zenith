import 'package:vector_math/vector_math.dart';

import 'drawable.dart';

/// A 3D cube.
abstract class Cube extends Drawable {
  final Vector3 position, size;
  final Vector4 color;

  Cube(this.position, this.size, this.color);
}
