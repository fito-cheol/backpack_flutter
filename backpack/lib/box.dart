import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'package:flame/src/cache/images.dart';
import 'package:flame/sprite.dart';

class Box extends RectangleComponent
    with TapCallbacks, DragCallbacks, HoverCallbacks {
  static const speed = 3;
  static const squareSize = 30.0;
  static const borderSize = 0.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();
  final BoxImage _boxImage =
      BoxImage(Vector2(0, 0), Vector2(squareSize, squareSize));
  late RectangleComponent innerBox;
  late RectangleComponent borderBox;

  Box(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(squareSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    borderBox = RectangleComponent(
        position: size / 2,
        size: Vector2.all(squareSize + borderSize),
        anchor: Anchor.center,
        paint: blue);
    innerBox = RectangleComponent(
      position: size / 2,
      size: Vector2.all(squareSize),
      anchor: Anchor.center,
    );

    add(borderBox);
    add(innerBox);
    add(_boxImage);
  }

  @override
  void onHoverEnter() {
    borderBox.paint = red;
  }

  @override
  void onHoverExit() {
    borderBox.paint = blue;
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   removeFromParent();
  //   event.handled = true;
  // }

  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   position += event.delta;
  // }
}

class BoxImage extends SpriteComponent with HasGameRef {
  BoxImage(Vector2 position, Vector2 size)
      : super(position: position, size: size);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('box.png');
    // position = gameRef.size / 2;
  }
}
