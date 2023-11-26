import 'package:flame/components.dart';

import 'box.dart';
import 'item.dart';

class Board extends Component {
  Vector2 position;
  int pixelSize;
  int widthNum;
  int heightNum;

  late List<List<Box>> boxList = [];

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
    boxList = [];
    for (var i = 0; i < height; i++) {
      List<Box> rowList = [];
      for (var j = 0; j < width; j++) {
        Vector2 point = startPoint + Vector2(size * j, size * i);
        Box newBox = Box(squareSize: size, position: point);
        rowList.add(newBox);
        add(newBox);
      }
      boxList.add(rowList);
    }
  }

  void makeTransBoxes() {
    for (final boxRow in boxList) {
      for (final box in boxRow) {
        box.makeWhite(false);
      }
    }
  }

  void receiveEvent(BoardEvent event, Item item) {
    if (event == BoardEvent.itemHover) {
      makeTransBoxes();
      Vector2 localPosition = item.position - position;
      int xPoint = (localPosition.x / pixelSize).round();
      int yPoint = (localPosition.y / pixelSize).round();
      int hLength = item.interactivePoint.length;
      int wLength = item.interactivePoint[0].length;

      for (var i = 0; i < hLength; i++) {
        int yIndex = yPoint + i;
        if (yIndex < 0 || yIndex >= heightNum) {
          continue;
        }
        for (var j = 0; j < wLength; j++) {
          int xIndex = xPoint + j;
          if (xIndex < 0 || xIndex >= widthNum) {
            continue;
          }
          if (item.interactivePoint[i][j] == 1) {
            boxList[yIndex][xIndex].makeWhite(true);
          }
        }
      }
    }
    if (event == BoardEvent.itemHoverEnd) {
      makeTransBoxes();
      // TODO: 놓을 수 있는 위치인지 확인하기
      Vector2 localPosition = item.position - position;
      int xPoint = (localPosition.x / pixelSize).round();
      int yPoint = (localPosition.y / pixelSize).round();
      Vector2 newPosition = Vector2((xPoint * pixelSize).toDouble(),
              (yPoint * pixelSize).toDouble()) +
          position;
      item.position = newPosition;
    }
  }
}

class BoardEvent {
  static BoardEvent itemHover = const BoardEvent(eventName: "itemHover");
  static BoardEvent itemHoverEnd = const BoardEvent(eventName: "itemHoverEnd");

  final String eventName;
  const BoardEvent({required this.eventName});
}
