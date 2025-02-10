import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:mobi_app/src/widgets/BrickGame.dart';

class Bat extends PositionComponent
    with DragCallbacks, HasGameReference<BrickGame> {
  Bat({
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, children: [RectangleHitbox()]);

  final Radius cornerRadius;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size.toSize(), cornerRadius),
      Paint()
        ..color = const Color.fromARGB(255, 115, 0, 150)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    double newX = (position.x + event.localDelta.x)
        .clamp(size.x / 2, game.width - size.x / 2); // Adjust for center anchor
    position.x = newX;
  }

  void movedBy(double dx) {
    double newX = (position.x + dx)
        .clamp(size.x / 2, game.width - size.x / 2); // Adjust for center anchor

    add(MoveToEffect(
      Vector2(newX, position.y), // Move only along X-axis
      EffectController(duration: 0.1),
    ));
  }
}
