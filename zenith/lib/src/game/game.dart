import '../assets/assets.dart';
import '../time/time.dart';

/// A game powered by the Zenith engine.
abstract class Game {
  /// The mechanism responsible for asynchronously loading game assets.
  AssetLoader get assetLoader;

  /// The mechanism responsible for handling and querying time.
  GameTimer get timer;
}