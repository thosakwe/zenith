import 'package:vector_math/vector_math.dart' hide Plane;
import '../objects/objects.dart';

/// A mechanism for managing display objects within a 3D universe.
abstract class World {
  /// Clears the display, and fills the canvas with the [color].
  void clear(Vector4 color);

  /// Normalizes an [x] coordinate within the aspect ratio of the game.
  double normalizeX(double x);

  /// Normalizes a [y] coordinate within the aspect ratio of the game.
  double normalizeY(double y);

  /// Normalizes a [z] coordinate within the aspect ratio of the game.
  double normalizeZ(double z);

  /// Creates a new [Cube].
  Cube createCube(Vector3 position, Vector3 size, Vector4 color);

  Plane2D createPlane(Vector3 position, Vector3 size, Vector4 color);
}