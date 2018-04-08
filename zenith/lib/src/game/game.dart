import '../assets/assets.dart';
import '../time/time.dart';
import 'scene_manager.dart';
import 'world.dart';

/// A game powered by the Zenith engine.
abstract class Game {
  /// The mechanism responsible for asynchronously loading game assets.
  AssetLoader get assetLoader;

  /// The mechanism responsible for controlling the content visible on the screen.
  SceneManager get sceneManager;

  /// The mechanism responsible for handling and querying time.
  GameTimer get timer;

  /// The mechanism responsible for drawing objects to the screen.
  World get world;
}