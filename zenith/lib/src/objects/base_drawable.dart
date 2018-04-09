import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';
import '../game/game.dart';
import '../game/world.dart';
import 'drawable.dart';

/// A base implementation of [Drawable].
abstract class BaseDrawable extends Drawable {
  final BaseTransform _transform = new BaseTransform();
  Matrix4 _position, _rotation = new Matrix4.zero(), _size, _originalSize;

  BaseDrawable(this._position, this._originalSize) {
    _size = _originalSize;
  }

  @override
  Matrix4 get position => _position;

  @override
  Matrix4 get rotation => _rotation;

  @override
  Transform get transform => _transform;

  @override
  Matrix4 get size => _size ?? _originalSize;

  @override
  @mustCallSuper
  void draw(Game game, World world) {
    applyTransform();
  }

  /// Applies the [transform] during this frame.
  void applyTransform() {
    _position
      ..translate(
          transform.translate.x, transform.translate.y, transform.translate.z)
      ..scale(transform.scale.x, transform.scale.y, transform.scale.z)
      ..rotateX(transform.rotate.x)
      ..rotateY(transform.rotate.y)
      ..rotateZ(transform.rotate.z);
  }
}

/// A base implementation of [Transform].
class BaseTransform implements Transform {
  Vector3 rotate = new Vector3.zero(),
      scale = new Vector3.all(1.0),
      translate = new Vector3.zero();

  void reset() {
    rotate = new Vector3.zero();
    //_scale.setZero();
    translate = new Vector3.zero();
  }
}
