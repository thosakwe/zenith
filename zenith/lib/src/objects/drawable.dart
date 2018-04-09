import 'package:vector_math/vector_math.dart';

import '../game/game.dart';
import '../game/world.dart';

/// An object that can be drawn to the screen.
abstract class Drawable {
  /// The position of this object.
  Matrix4 get position;

  /// The current rotation of this object.
  Matrix4 get rotation;

  /// The size of this object.
  Matrix4 get size;

  /// The transformations to apply during this frame.
  Transform get transform;

  /// Draws this object to the screen.
  void draw(Game game, World world);
}

/// A wrapper for object transformations.
abstract class Transform {
  /// The translation vector to apply during this frame.
  Vector3 translate;

  /// The rotation vector to apply during this frame.
  Vector3 rotate;

  /// The scale vector to apply during this frame.
  Vector3 scale;
}