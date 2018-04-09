import 'package:vector_math/vector_math.dart' hide Plane;

import 'base_drawable.dart';

/// A 2D plane.
abstract class Plane extends BaseDrawable {
  Plane(Matrix4 position, Matrix4 originalSize) : super(position, originalSize);

  /// The color of the plane.
  Vector4 get color;
}