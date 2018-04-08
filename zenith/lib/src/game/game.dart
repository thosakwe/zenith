import '../assets/assets.dart';

/// A game powered by the Zenith engine.
abstract class Game {
  /// The mechanism responsible for asynchronously loading game assets.
  AssetLoader get assetLoader;
}