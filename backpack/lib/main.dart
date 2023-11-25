import 'package:backpack/board.dart';
import 'package:backpack/box.dart';
import 'package:backpack/item.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

class MyGame extends FlameGame with TapCallbacks {
  late Sprite box;
  Item? draggedItem;
  int pixelSize = 30;
  final Vector2 boardPosition = Vector2(30, 30);

  @override
  Future<void> onLoad() async {
    add(Board(
        position: boardPosition,
        pixelSize: pixelSize,
        widthNum: 4,
        heightNum: 3));
    add(Item(size / 2));
  }

  void onItemDrag(Item item) {
    draggedItem = item;
  }

  void onItemDragEnd() {
    draggedItem = null;
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   super.onTapDown(event);
  //   if (!event.handled) {
  //     final touchPoint = event.canvasPosition;
  //     add(Square(touchPoint));
  //   }
  // }
}
