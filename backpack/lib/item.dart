import 'package:backpack/main.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Item extends RectangleComponent
    with TapCallbacks, DragCallbacks, HoverCallbacks, HasGameRef<MyGame> {
  static const squareSize = 30.0;
  static const borderSize = 4.0;

  static final Paint white = BasicPalette.white.withAlpha(255).paint();
  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();
  static final Paint whiteTrans = BasicPalette.white.withAlpha(50).paint();

  ItemInfo itemInfo;
  late RectangleComponent border;
  late final ItemImage _itemImage;

  // static final Anchor anchor_vector = Anchor.center; // 클릭했을 때의 중심 anchor
  // static final Vector2 item_center = Vector2(2, 2);
  // 그릴 sprite (no interaction)

  List<List> get interactivePoint => itemInfo.interactablePoint;

  Item(Vector2 position, {required this.itemInfo})
      : super(
          position: position,
          size: Vector2(squareSize * 2, squareSize),
          anchor: Anchor.topLeft,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _itemImage = ItemImage(Vector2(0, 0),
        Vector2(itemInfo.width * squareSize, itemInfo.height * squareSize),
        itemInfo: itemInfo);
    border = RectangleComponent(
        position: Vector2.all(borderSize * -0.5),
        size: Vector2(squareSize * 2 + borderSize, squareSize + borderSize),
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
    gameRef.onItemDrag(this);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    gameRef.onItemDragEnd(this);
  }
}

class ItemImage extends SpriteComponent with HasGameRef {
  ItemInfo itemInfo;
  ItemImage(Vector2 position, Vector2 size, {required this.itemInfo})
      : super(position: position, size: size);
  @override
  Future<void> onLoad() async {
    super.onLoad();

    String itemPath = 'item/${itemInfo.itemName}.png';
    sprite = await gameRef.loadSprite(itemPath);
  }
}

class ItemInfo {
  static ItemInfo pig = ItemInfo(itemName: 'lucky_piggy', interactablePoint: [
    [1, 1]
  ]);

  String itemName;
  List<List> interactablePoint;
  get width => interactablePoint[0].length;
  get height => interactablePoint.length;
  ItemInfo({required this.itemName, required this.interactablePoint});
}
