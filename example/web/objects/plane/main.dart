import 'package:zenith_html/zenith_html.dart';
import 'scenes/boot.dart';

void main() {
  var game = new HtmlGame.createCanvas('game', 800, 600);
  game.sceneManager.run(bootScene);
}