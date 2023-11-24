import 'dart:math' as math;

import 'package:backpack/box.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'square.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
class MyGame extends FlameGame with TapCallbacks {
  @override
  Future<void> onLoad() async {
    // add(Square(size / 2));
    add(Box(Vector2(35, 35)));
    addBoxes(Vector2(105, 105), 70, 4, 3);
  }

  void addBoxes(startPoint, size, width, height) {
    for (var i = 0; i < width; i++) {
      for (var j = 0; j < height; j++) {
        Vector2 point = startPoint + Vector2(size * i, size * j);
        add(Box(point));
      }
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      add(Square(touchPoint));
    }
  }
}
