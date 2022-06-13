import 'package:brain_master/view_models/game_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'cell.dart';

class Board extends StatefulWidget {
  final int side;
  final List values;
  final List hIndex;
  final List eCell;

  const Board({
    Key? key,
    required this.side,
    required this.values,
    required this.hIndex,
    required this.eCell
  }) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late int activeCell;

  @override
  void initState() {
    activeCell = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: widget.side,
        childAspectRatio: 1,
        children: List.generate(widget.side*widget.side, (index) {
          return Cell(
              isEmpty: widget.eCell.contains(index),
              value: widget.values[index],
              isActive: activeCell==index,
              isPlaceholder: widget.hIndex.contains(index),
              onClick: (){
                setState(() {
                  activeCell = index;
                });
              },
              onTextChange: (val){

                GameViewModel.answers[index] = val=='' ? 404 : val;

                print(GameViewModel.answers);
              },
          );
        }
        )
    );
  }
}
