import 'dart:async';
import 'dart:html' show CanvasRenderingContext;
import 'package:async/async.dart';
import 'package:zenith/zenith.dart';
import 'game.dart';

/// A WebGL-based [SceneManager].
class HtmlSceneManager extends SceneManager {
  final HtmlGame game;
  Scene _scene;
  CancelableOperation _timerListener;

  HtmlSceneManager(this.game);

  @override
  Scene get currentScene => _scene;

  @override
  void run(Scene scene, [params]) {
    // Dispose of the current scene.
    Future dispose = _scene == null
        ? new Future.value()
        : new Future(() async {
            await _scene.close(game);
            await _timerListener.cancel();
          });

    dispose.then((_) async {
      _scene = scene;
      // Initialize the new scene
      await scene.init(game, params);

      // Now, we just need to start the scene.
      await scene.create(game);

      // Lastly, add a timer loop that periodically runs update.
      _timerListener = game.timer.loop(() async {
        await scene.update(game);
        if (game.debug) await scene.debug(game);
        game.render();
      }, const Duration(milliseconds: 1000 ~/ 60));
    });
  }
}
