import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Box extends RectangleComponent
    with TapCallbacks, DragCallbacks, HoverCallbacks {
  static const speed = 3;
  double squareSize;
  static const borderSize = 0.0;

  static final Paint whiteLessTrans = BasicPalette.white.withAlpha(120).paint();
  static final Paint whiteTrans = BasicPalette.white.withAlpha(10).paint();
  late final BoxImage _boxImage =
      BoxImage(Vector2(0, 0), Vector2(squareSize, squareSize));

  late RectangleComponent hoverBox;

  Box({required this.squareSize, required super.position})
      : super(
          size: Vector2.all(squareSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    hoverBox = RectangleComponent(
        position: size / 2,
        size: Vector2.all(squareSize),
        anchor: Anchor.center,
        paint: whiteTrans);

    add(_boxImage);
    add(hoverBox);
  }

  makeWhite(bool yesWhite) {
    if (yesWhite) {
      hoverBox.paint = whiteTrans;
    } else {
      hoverBox.paint = whiteLessTrans;
    }
  }
}

class BoxImage extends SpriteComponent with HasGameRef {
  BoxImage(Vector2 position, Vector2 size)
      : super(position: position, size: size);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('box.png');
  }
}
