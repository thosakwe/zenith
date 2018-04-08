import 'dart:async';
import '../game/game.dart';

/// A scene in a Zenith game. Only one scene will be running at a time.
abstract class Scene {
  /// Use this method to declare assets that should be loaded before [create] is called.
  Future load(Game game) async {}

  /// Use this method to initialize objects within the [game] once the scene is created;
  Future create(Game game) async {}

  /// Use this method to perform checks, once-per-tick.
  Future update(Game game) async {}

  /// This method will only be called if [game] is running in debug mode, and runs once a frame, after [update].
  Future debug(Game game) async {}

  /// Use this method to dispose of any resources created in this scene and prevent a memory leak.
  Future close(Game game) async {}
}
