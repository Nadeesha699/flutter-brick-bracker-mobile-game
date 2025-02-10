import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mobi_app/src/components/Ball.dart';
import 'package:mobi_app/src/components/Bat.dart';
import 'package:mobi_app/src/config.dart';
import 'package:mobi_app/src/widgets/BrickGame.dart';

class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameReference<BrickGame> {
  Brick({required super.position, required Color color})
      : super(
            size: Vector2(brickWidth, brickHeight),
            anchor: Anchor.center,
            paint: Paint()
              ..color = color
              ..style = PaintingStyle.fill,
            children: [RectangleHitbox()]);

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    game.score.value++;  
    if (game.world.children.query<Brick>().length == 1) {
      game.playState = PlayState.won; 
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }
}
