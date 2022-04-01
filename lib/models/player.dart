import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player {
  String name;
  UniqueKey? id;
  int playedMatches = 0;
  Color? color;
  int score = 0;

  Player(this.name, [this.color]) {
    id = UniqueKey();
    color ??= _randomColor();
  }

  Color _randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  String toString() {
    return "$id: $name";
  }
}
