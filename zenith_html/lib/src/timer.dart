import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart';
import 'package:zenith/zenith.dart';

/// A [GameTimer] implementation that uses the [Timer] from `dart:async`.
class GameTimerImpl extends GameTimer {
  final Queue<_TimerEvent> _events = new Queue();
  Timer _timer;

  GameTimerImpl();

  @override
  void start() {
    _timer ??=
    new Timer.periodic(const Duration(milliseconds: 1), _timerCallback);
  }

  @override
  int get elapsedMilliseconds => _timer.tick;

  Future close() async {
    while (_events.isNotEmpty)
      _events.removeFirst().completer.completeError(
          new StateError('The timer was closed before this operation closed.'));

    _timer.cancel();
  }

  CancelableOperation<T> _addEvent<T>(
      FutureOr<T> callback(), Duration delay, bool loop) {
    var event = new _TimerEvent(callback, delay, loop);
    var c = event.completer =
        new CancelableCompleter(onCancel: () => _events.remove(event));
    _events.add(event);
    return c.operation;
  }

  @override
  CancelableOperation<T> run<T>(FutureOr<T> callback(),
      [Duration delay = Duration.zero]) {
    return _addEvent(callback, delay, false);
  }

  @override
  CancelableOperation<T> loop<T>(FutureOr<T> callback(),
      [Duration delay = Duration.zero]) {
    return _addEvent(callback, delay, true);
  }

  void _timerCallback(_) {
    var remove = <_TimerEvent>[];

    for (var event in _events) {
      if (!event.loop) remove.add(event);

      if (event.lastRun == null ||
          ((new Duration(milliseconds: _timer.tick) - event.lastRun) >=
              event.delay)) {
        event.lastRun = new Duration(milliseconds: _timer.tick);
        event.callback();
      }
    }

    for (var event in remove) {
      _events.remove(event);
      if (!event.completer.isCanceled && !event.completer.isCompleted)
        event.completer.complete();
    }
  }
}

class _TimerEvent<T> {
  final FutureOr<T> Function() callback;
  final Duration delay;
  final bool loop;
  CancelableCompleter completer;
  Duration lastRun;

  _TimerEvent(this.callback, this.delay, this.loop);
}
