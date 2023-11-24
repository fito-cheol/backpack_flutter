import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Square extends RectangleComponent with TapCallbacks, DragCallbacks {
  static const speed = 3;
  static const squareSize = 128.0;
  static const indicatorSize = 6.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();

  Square(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(squareSize),
          anchor: Anchor.center,
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
