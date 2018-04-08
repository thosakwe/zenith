import 'package:vector_math/vector_math.dart';

import '../game/game.dart';
import '../game/world.dart';

/// An object that can be drawn to the screen.
abstract class Drawable {
  /// The position of this object.
  Vector3 get position;

  /// Draws this object to the screen.
  void draw(Game game, World world);
}
