import 'package:vector_math/vector_math.dart' hide Plane;
import '../objects/objects.dart';

/// A mechanism for managing display objects within a 3D universe.
abstract class World {
  /// The size of the world.
  Vector3 get size;

  /// The game's [Camera].
  Camera get camera;

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

/// A mechanism for controlling the game's field of view.
abstract class Camera {
  num get aspectRatio;

  /// This camera, represented as a [Matrix4].
  Matrix4 get matrix;

  /// The min/max distance for objects in the [Camera].
  double minDistance, maxDistance;

  /// The field of view, in degrees.
  num fieldOfViewDegrees;
}

/// A [Camera] that simulates the distortion of perspective in a real camera.
abstract class PerspectiveCamera extends Camera {
  PerspectiveCamera() {
    fieldOfViewDegrees = 45;
    minDistance = 0.1;
    maxDistance = 100.0;
  }

  @override
  Matrix4 get matrix {
    var mat = new Matrix4.identity();
    setPerspectiveMatrix(
      mat,
      radians(fieldOfViewDegrees),
      aspectRatio,
      minDistance,
      maxDistance,
    );
    return mat;
  }
}