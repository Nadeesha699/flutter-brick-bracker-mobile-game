import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mobi_app/src/widgets/BrickGame.dart';

class PlayArea extends RectangleComponent with HasGameReference<BrickGame> {
  PlayArea()
      : super(
            paint: Paint()..color = const Color.fromARGB(196, 94, 180, 255),
            children: [RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
