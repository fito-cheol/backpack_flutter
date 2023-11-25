import 'package:flame/components.dart';

import 'box.dart';

class Board extends Component {
  Vector2 position;
  int pixelSize;
  int widthNum;
  int heightNum;

  Board(
      {required this.position,
      required this.pixelSize,
      required this.widthNum,
      required this.heightNum});

  @override
  Future<void> onLoad() async {
    addBoxes(position, pixelSize, widthNum, heightNum);
  }

  void addBoxes(startPoint, size, width, height) {
    for (var i = 0; i < width; i++) {
      for (var j = 0; j < height; j++) {
        Vector2 point = startPoint + Vector2(size * i, size * j);
        add(Box(squareSize: size, position: point));
      }
    }
  }
}
