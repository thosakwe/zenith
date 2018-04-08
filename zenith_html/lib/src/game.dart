import 'dart:html' show document, window, CanvasElement, CanvasRenderingContext;
import 'dart:web_gl';
import 'package:zenith/zenith.dart';
import 'scene_manager.dart';
import 'timer.dart';
import 'xhr_asset_loader.dart';

/// A [Game] implementation that runs in the browser.
class HtmlGame extends Game {
  @override
  final AssetLoader assetLoader = new XHRAssetLoader();

  @override
  final GameTimer timer = new GameTimerImpl();

  /// Call `debug` on the current [Scene] every frame.
  final bool debug;

  final CanvasElement canvas;

  HtmlSceneManager _sceneManager;

  HtmlGame(this.canvas, {this.debug: false}) {
    _sceneManager = new HtmlSceneManager(this);
  }

  @override
  SceneManager get sceneManager => _sceneManager;

  /// Creates a new canvas to run a game in before instantiating.
  factory HtmlGame.createCanvas(String id, int width, int height,
      {bool debug: false}) {
    var canvas = new CanvasElement(width: width, height: height)..id = id;
    document.body.children.add(canvas);
    return new HtmlGame(canvas, debug: debug);
  }

  /// Draws the current game contents.
  void render() {

  }
}
