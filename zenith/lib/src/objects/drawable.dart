import 'package:vector_math/vector_math.dart';

import '../game/game.dart';
import '../game/world.dart';

/// An object that can be drawn to the screen.
abstract class Drawable {
  /// The position of this object.
  Vector3 get position;

  /// The size of this object.
  Vector3 get size;

  /// The scale of this object.
  Vector3 get scale;

  /// Draws this object to the screen.
  void draw(Game game, World world);
}

/// A wrapper for object transformations.
abstract class Transform {
  /// The translation vector to apply during this frame.
  Vector3 get translate;

  /// The rotation vector to apply during this frame.
  Vector3 get rotate;

  /// The scale vector to apply during this frame.
  Vector3 get scale;
}