import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Item extends RectangleComponent with TapCallbacks, DragCallbacks {
  static const speed = 3;
  static const squareSize = 30.0;
  static const borderSize = 5.0;
  static const indicatorSize = 6.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();
  // interactable한 사각형 만들 수 있는 범위
  static const List<List> interactable_point = [
    [0, 1, 0],
    [1, 1, 1]
  ];
  // static final Anchor anchor_vector = Anchor(0.5, 0.25);
  // 클릭했을 때의 중심 anchor
  // static final Vector2 item_center = Vector2(2, 2);
  // 그릴 sprite (no interaction)

  Item(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(squareSize),
          anchor: const Anchor(0.5, 0.25),
        );

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      RectangleComponent(
        size: Vector2.all(indicatorSize),
        paint: blue,
      ),
    );
    add(
      RectangleComponent(
        position: size / 2,
        size: Vector2.all(indicatorSize),
        anchor: Anchor.center,
        paint: red,
      ),
    );
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   removeFromParent();
  //   event.handled = true;
  // }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.delta;
  }
}
