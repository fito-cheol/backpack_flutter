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
  late Board board;
  Item? draggedItem;
  int pixelSize = 30;
  final Vector2 boardPosition = Vector2(100, 100);

  @override
  Future<void> onLoad() async {
    board = Board(
        position: boardPosition,
        pixelSize: pixelSize,
        widthNum: 10,
        heightNum: 15);
    add(board);
    add(Item(size / 2, itemInfo: ItemInfo.pig));
    add(Item(size / 2, itemInfo: ItemInfo.banana));
    add(Item(size / 2, itemInfo: ItemInfo.thronWhip));
  }

  void onItemDrag(Item item) {
    draggedItem = item;
    board.receiveEvent(BoardEvent.itemHover, item);
  }

  void onItemDragEnd(Item item) {
    draggedItem = null;
    board.receiveEvent(BoardEvent.itemHoverEnd, item);
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
