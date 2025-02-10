import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobi_app/src/components/Bat.dart';
import 'package:mobi_app/src/components/Brick.dart';
import 'package:mobi_app/src/components/playArea.dart';
import 'package:mobi_app/src/widgets/BrickGame.dart';

class Ball extends CircleComponent
    with HasGameReference<BrickGame>, CollisionCallbacks {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
          radius: radius,
          children: [CircleHitbox()],
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color.fromARGB(211, 255, 255, 255)
            ..style = PaintingStyle.fill,
        );

  final Vector2 velocity;
  final double difficultyModifier;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0 ||
          intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        game.playState = PlayState.gameOver;
      }
    } else if (other is Bat) {
      velocity.y = -velocity.y;

      velocity.x += (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else if (other is Brick) {
      double ballCenterX = position.x;
      double ballCenterY = position.y;
      double brickCenterX = other.position.x + other.size.x / 2;
      double brickCenterY = other.position.y + other.size.y / 2;

      double dx = (ballCenterX - brickCenterX).abs();
      double dy = (ballCenterY - brickCenterY).abs();

      if (dx > dy) {
        velocity.x = -velocity.x;
      } else {
        velocity.y = -velocity.y;
      }

      velocity.setFrom(velocity * difficultyModifier);
    }
  }
}
