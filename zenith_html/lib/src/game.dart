import 'dart:async';
import 'dart:html' show document, window, CanvasElement, CanvasRenderingContext;
import 'dart:web_gl';
import 'package:zenith/zenith.dart';
import 'scene_manager.dart';
import 'timer.dart';
import 'webgl_world.dart';
import 'xhr_asset_loader.dart';

/// A [Game] implementation that runs in the browser.
class HtmlGame extends Game {
  @override
  final AssetLoader assetLoader = new XHRAssetLoader();

  /// Call `debug` on the current [Scene] every frame.
  final bool debug;

  final CanvasElement canvas;

  HtmlSceneManager _sceneManager;

  GameTimerImpl _timer;

  WebGLWorld _world;

  HtmlGame(this.canvas, {this.debug: false}) {
    _sceneManager = new HtmlSceneManager(this);
    _timer = new GameTimerImpl();
    _world = new WebGLWorld(canvas, this);
  }

  @override
  SceneManager get sceneManager => _sceneManager;

  @override
  GameTimer get timer => _timer;

  @override
  WebGLWorld get world => _world;

  /// Creates a new canvas to run a game in before instantiating.
  factory HtmlGame.createCanvas(String id, int width, int height,
      {bool debug: false}) {
    var canvas = new CanvasElement(width: width, height: height)..id = id;
    document.body.children.add(canvas);
    return new HtmlGame(canvas, debug: debug);
  }

  Future close() async {
    await _timer.close();
  }

  /// Draws the current game contents.
  void render() {}
}
