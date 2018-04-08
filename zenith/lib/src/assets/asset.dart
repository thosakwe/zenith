import 'dart:async';
import 'package:async/async.dart';

/// A piece of data produced by an expensive computation.
/// 
/// Internally, this class uses an [AsyncMemoizer] to ensure
/// that the computation only is ever run once.
abstract class Asset<T> {
  final AsyncMemoizer<T> _memoizer = new AsyncMemoizer();

  /// Gets the value of this asset, either through computation or a memoized value.
  Future<T> get value => _memoizer.runOnce(loadFresh);

  /// Loads the value. This is the function called by the [AsyncMemoizer].
  FutureOr<T> loadFresh();
}
