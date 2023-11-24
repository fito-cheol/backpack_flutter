import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Box extends RectangleComponent with TapCallbacks, DragCallbacks {
  static const speed = 3;
  static const squareSize = 60.0;
  static const borderSize = 5.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();

  Box(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(squareSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      RectangleComponent(
          position: size / 2,
          size: Vector2.all(squareSize + borderSize),
          anchor: Anchor.center,
          paint: blue),
    );
    add(
      RectangleComponent(
        position: size / 2,
        size: Vector2.all(squareSize),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    event.handled = true;
  }

  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   position += event.delta;
  // }
}
