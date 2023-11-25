import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Item extends RectangleComponent
    with TapCallbacks, DragCallbacks, HoverCallbacks {
  static const squareSize = 30.0;
  static const borderSize = 4.0;

  static final Paint white = BasicPalette.white.withAlpha(255).paint();
  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();
  static final Paint whiteTrans = BasicPalette.white.withAlpha(50).paint();
  // interactable한 사각형 만들 수 있는 범위
  static const List<List> interactable_point = [
    [1, 1]
  ];
  late RectangleComponent border;
  final ItemImage _itemImage =
      ItemImage(Vector2(0, 0), Vector2(squareSize * 2, squareSize));
  // static final Anchor anchor_vector = Anchor.center; // 클릭했을 때의 중심 anchor
  // static final Vector2 item_center = Vector2(2, 2);
  // 그릴 sprite (no interaction)

  Item(Vector2 position)
      : super(
          position: position,
          size: Vector2(squareSize * 2, squareSize),
          anchor: const Anchor(0.5, 0.5),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    border = RectangleComponent(
        position: Vector2.all(borderSize * -0.5),
        size: Vector2(squareSize * 2 + borderSize, squareSize + borderSize),
        // anchor: Anchor.center,
        paint: whiteTrans);
    add(border);
    add(_itemImage);
  }

  @override
  void onHoverEnter() {
    border.paint = white;
  }

  @override
  void onHoverExit() {
    border.paint = whiteTrans;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.delta;
  }
}

class ItemImage extends SpriteComponent with HasGameRef {
  ItemImage(Vector2 position, Vector2 size)
      : super(position: position, size: size);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('item/lucky_piggy.png');
  }
}
