import '../scene/scene.dart';

/// A mechanism for controlling the current display of a Zenith game.
abstract class SceneManager {
  /// The scene currently running.
  Scene get currentScene;

  /// Runs the given [scene], passing any optional [params].
  void run(Scene scene, [params]);
}