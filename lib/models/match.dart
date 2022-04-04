import 'package:flutter/cupertino.dart';
import 'package:yatzy/models/player.dart';
import 'package:yatzy/models/yatzy_board.dart';

class Match {
  UniqueKey? id;
  List<Player> players = [];
  Duration elpasedTime = Duration.zero;
  int turn = 0, maxTurns = scoreLabel.values.length;
  int? _currentPlayerIndex;
  Player? _currentPlayer;
  Player? winner;

  Match() {
    id = UniqueKey();
  }

  @override
  String toString() {
    String t = "";
    t += "* players: $players";
    t += "\n* Current round: $turn";
    t += "\n* Current Players turn: $_currentPlayer";

    return t;
  }

  void addPlayer(Player player) => players.add(player);

  void addPlayers(List<Player> players) => this.players.addAll(players);

  Player? get currentPlayer => _currentPlayer;

  void setCurrentPlayer(int index) {
    assert(index <= players.length - 1);
    _currentPlayer = players.elementAt(index);
  }

  void removePlayer(UniqueKey id) {
    players.removeWhere((player) => player.id == id);
  }

  void startMatch() {
    turn = 1;
    _currentPlayer = players.first;
    _currentPlayerIndex = 0;
  }

  void _finishMatch() {
    Player? winner = players.fold<Player>(
      players.first,
      (previousPlayer, player) =>
          player.board.score > previousPlayer.board.score
              ? player
              : previousPlayer,
    );
    // TODO: Pick Winner
    // TODO: Store statistics
  }

  bool nextPlayer() {
    if (currentPlayer == players.last) {
      return false;
    }
    _currentPlayerIndex = _currentPlayerIndex! + 1;
    _currentPlayer = players.elementAt(_currentPlayerIndex!);
    return true;
  }

  void nextTurn() {
    if (turn == maxTurns) {
      _finishMatch();
      return;
    }
    turn++;
    _currentPlayer = players.first;
    _currentPlayerIndex = 0;
  }
}
