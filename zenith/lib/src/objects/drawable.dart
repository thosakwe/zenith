import 'package:vector_math/vector_math.dart';

import '../game/game.dart';
import '../game/world.dart';

/// An object that can be drawn to the screen.
abstract class Drawable {
  /// The position of this object.
  Vector3 position;

  /// Draws this object to the screen.
  void draw(Game game, World world);
}

/// A [Drawable] with an expressed size.
abstract class SizedDrawable extends Drawable {
  /// The size of this object.
  Vector3 size;

  @override
  Vector3 position;

  SizedDrawable(this.position, this.size);
}

/// A [SizedDrawable] with a uniform color.
abstract class MonochromeDrawable extends SizedDrawable {
  /// The color of this object.
  Vector4 color;

  MonochromeDrawable(Vector3 position, Vector3 size, this.color)
      : super(position, size);
}
