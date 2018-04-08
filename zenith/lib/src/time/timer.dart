import 'dart:async';
import 'package:async/async.dart';

/// A mechanism to query time in Zenith.
abstract class GameTimer {
  /// The total number of ticks that have passed.
  int get elapsedMilliseconds;

  /// Runs an operation at a certain time in the future.
  CancelableOperation<T> run<T>(FutureOr<T> callback(),
      [Duration delay = Duration.zero]);

  /// Continuously runs an operation, with a given [delay] between consecutive runs.
  CancelableOperation<T> loop<T>(FutureOr<T> callback(),
      [Duration delay = Duration.zero]);

  /// Starts the timer.
  void start();
}
