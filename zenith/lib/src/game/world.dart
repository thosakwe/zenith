import 'package:vector_math/vector_math.dart';

/// A mechanism for managing display objects within a 3D universe.
abstract class World {
  /// Clears the display, and fills the canvas with the [color].
  void clear(Vector4 color);
}