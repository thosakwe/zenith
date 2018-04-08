import 'dart:async';
import 'package:meta/meta.dart';
import '../game/game.dart';

/// A scene in a Zenith game. Only one scene will be running at a time.
abstract class Scene {
  /// Use this method to declare assets that should be loaded before [create] is called.
  @mustCallSuper
  Future load(Game game) => game.assetLoader.loadAllAssets().value;

  /// Use this method to initialize objects within the [game] once the scene is created;
  @mustCallSuper
  Future create(Game game) async {}

  /// Use this method to perform checks, once-per-tick.
  @mustCallSuper
  Future update(Game game) async {}

  /// This method will only be called if [game] is running in debug mode, and runs once a frame, after [update].
  @mustCallSuper
  Future debug(Game game) async {}

  /// Use this method to dispose of any resources created in this scene and prevent a memory leak.
  @mustCallSuper
  Future close(Game game) async {}
}
