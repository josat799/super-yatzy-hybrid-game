import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yatzy/models/yatzy_board.dart';

class Player {
  String name;
  late UniqueKey id;
  late YatzyBoard board;
  int playedMatches = 0;
  Color? color;

  Player(this.name, [this.color]) {
    id = UniqueKey();
    color ??= _randomColor();
    board = YatzyBoard();
  }

  Color _randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  String toString() {
    return "$id: $name";
  }
}
