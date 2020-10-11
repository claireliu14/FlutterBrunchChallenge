import 'package:flutter/material.dart';
import 'dart:async';

class PacManScreen extends StatefulWidget {
  @override
  _PacManScreenState createState() => _PacManScreenState();
}

class _PacManScreenState extends State<PacManScreen> {
  final int numberInRow = 10;
  final int numberOfSquare = 17;
  final List<int> barriers = [
    0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
    10,                                 19,
    20,     22, 23, 24, 25, 26, 27,     29,
    30,     32,                         39,
    40,     42, 43, 44,     46, 47,     49,
    50,                     56, 57,     59,
    60,     62, 63, 64,     66, 67,     69,
    70,     72, 73, 74,     76, 77,     79,
    80,                                 89,
    90,     92, 93, 94, 95,     97,     99,
    100,                        107,    109,
    110,    112,113,114,115,116,117,    119,
    120,                        127,    129,
    130,    132,133,134,135,    137,    139,
    140,    142,                        149,
    150,            154,155,156,157,    159,
    160,161,162,163,164,165,166,167,168,169
  ];

  int pacmanPosition = 151;
  int orientation = 1;  // right:0, top:1, left:2, bottom:3

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 600), (timer) {
      switch (orientation) {
        case 0:
          final next = pacmanPosition + 1;
          if(!barriers.contains(next)) {
            setState(() => pacmanPosition = next);
          }
          break;
        case 1:
          final next = pacmanPosition - numberInRow;
          if(!barriers.contains(next)) {
            setState(() => pacmanPosition = next);
          }
          break;
        case 2:
          final next = pacmanPosition - 1;
          if(!barriers.contains(next)) {
            setState(() => pacmanPosition = next);
          }
          break;
        case 3:
          final next = pacmanPosition + numberInRow;
          if(!barriers.contains(next)) {
            setState(() => pacmanPosition = next);
          }
          break;
      }
    });
  }

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
            child: GestureDetector(
              onVerticalDragUpdate: (drag) {
                if(drag.delta.dy < 0) {
                    orientation = 1;
                } else if(drag.delta.dy > 0) {
                    orientation = 3;
                }
              },
              onHorizontalDragUpdate: (drag) {
                if(drag.delta.dx > 0) {
                    orientation = 0;
                } else if(drag.delta.dx < 0) {
                    orientation = 2;
                }
              },
              child: Container(
                  color: Colors.red.shade200,
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: numberInRow * numberOfSquare,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: numberInRow,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0),
                      itemBuilder: (context, index) {

                        if(barriers.contains(index)) { // barrier
                          return Container(
                              color: Colors.grey ,
                              child: Text(
                                '$index',
                              ));
                        } else {
                          if(index == pacmanPosition) {
                            return Container(
                                color: Colors.deepOrange,
                                child: Image.asset("images/pacman.png"));
                          } else {
                            return Container(
                                color: Colors.deepOrange,
                                child: Text(
                                  '$index',
                                ));
                          }
                        }
                      })),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,

              ///              child:   這邊可以放 分數 或 開始遊戲 按鈕
            ),
          ),
        ],
      ),
    );
  }
}
