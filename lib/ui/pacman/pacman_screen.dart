import 'package:flutter/material.dart';
import 'package:flutter_brunch_challenge/ui/pacman/barrier_map.dart';

import 'component/path_square.dart';
import 'component/square.dart';

class PacManScreen extends StatefulWidget {
  @override
  _PacManScreenState createState() => _PacManScreenState();
}

class _PacManScreenState extends State<PacManScreen> {

  static int _numberInRow = 11;
  static int _numberInColumn = 17;
  int _numberOfSquares = _numberInRow * _numberInColumn;
  int player = _numberInRow * (_numberInColumn - 2) + 1;
  List _barriers = PacManMap().barriers;

  @override
  Widget build(BuildContext context) {
    ///    小精靈圖檔
    ///    Image.asset("images/pacman.png")
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: GridView.builder(
                itemCount: _numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _numberInRow,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == player) {
                    return  Image.asset("images/pacman.png");
                  }
                  if (_barriers.contains(index)) {
                    return Square(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.cyan,
                      child: Text('$index'),
                    );
                  }
                  return PathSquare(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.yellow,
                    child: Text('$index'),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,

              ///              child:   這邊可以放 分數 或 開始遊戲 按鈕
            ),
          ),
        ],
      ),
    );
  }
}
