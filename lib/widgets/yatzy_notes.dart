import 'package:flutter/material.dart';
import 'package:yatzy/models/player.dart';
import 'package:yatzy/models/yatzy_board.dart';

class YatzyNotes extends StatelessWidget {
  final Player player;
  const YatzyNotes({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          YatzyBoard board = player.board;
          var boardMap = board.boardMap;
          return Column(
            children: [
              Text(
                boardMap.keys.toList().elementAt(index).name,
              ),
              boardMap.entries.elementAt(index).value.isSet
                  ? Text(
                      boardMap.entries.elementAt(index).value.score!.toString())
                  : TextFormField(),
            ],
          );
        },
        itemCount: scoreLabel.values.length);
  }
}
