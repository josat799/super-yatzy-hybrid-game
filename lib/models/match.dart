import 'package:flutter/cupertino.dart';
import 'package:yatzy/models/player.dart';

class Match {
  UniqueKey? id;
  List<Player> players = [];
  Duration elpasedTime = Duration.zero;
  int turn = 0;
  Player? _currentPlayer;
  // TODO: Add data tables

  Match() {
    id = UniqueKey();
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  Player? get currentPlayer => _currentPlayer;

  void removePlayer(UniqueKey id) {
    players.removeWhere((player) => player.id == id);
  }

  void startMatch() {
    turn = 0;
    _currentPlayer = players.first;
  }

  void finishMatch() {
    // TODO: Pick Winner
    // TODO: Store statistics
  }

  void nextPlayer(int index) {
    _currentPlayer = players.elementAt(index);
  }

  void nextTurn() {
    turn++;
    _currentPlayer = players.first;
  }
}
