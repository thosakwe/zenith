import 'dart:html' show document, window, CanvasElement, CanvasRenderingContext;
import 'dart:web_gl';
import 'package:zenith/zenith.dart';

/// A [Game] implementation that runs in the browser.
class HtmlGame extends Game {
  final CanvasElement canvas;

  HtmlGame(this.canvas);

  /// Creates a new canvas to run a game in before instantiating.
  factory HtmlGame.createCanvas(String id, int width, int height) {
    var canvas = new CanvasElement(width: width, height: height)..id = id;
    document.body.children.add(canvas);
    return new HtmlGame(canvas);
  }
}