class Score {
  int? score;
  bool isSet = false;
  scoreLabel label;
  Score(this.label);

  @override
  String toString() {
    return "${label.name}: ${isSet ? score : null}";
  }
}

class YatzyBoard {
  static const int YATZY = 50,
      LARGESTRAIGHT = 20,
      SMALLSTRAIGHT = 15,
      BONUS = 50,
      BONUSCRITERIA = 63;

  static const List<scoreLabel> UPPER = [
    scoreLabel.ones,
    scoreLabel.twos,
    scoreLabel.threes,
    scoreLabel.fours,
    scoreLabel.fives,
    scoreLabel.sixes
  ];
  final Map<int, int> _shortCutValues = {
    -5: 0,
    -4: 0,
    -2: 1,
    -1: 2,
    0: 3,
    1: 4,
    2: 5
  };

  bool hasYatzy = false, hasBonus = false;

  late Map<scoreLabel, Score> _boardMap;
  late Map<scoreLabel, int> _upperBank;
  int upperScore = 0;
  int _bankScore = 0;

  int score = 0;

  YatzyBoard() {
    _boardMap = <scoreLabel, Score>{};
    _upperBank = <scoreLabel, int>{};
    // ignore: avoid_function_literals_in_foreach_calls
    scoreLabel.values.forEach((element) => _boardMap[element] = Score(element));
    UPPER.forEach((element) => _upperBank[element] = 0);
  }

  @override
  String toString() {
    String t = "";
    t += "* Current Score $score";
    t += "\n* Current upper Score $upperScore";
    t += "\n* Current bank Score $_bankScore";
    t += "\n* Current upper Score $_upperBank";
    t += "\n* Has Yatzy $hasYatzy";
    t += "\n* Has bonus $hasBonus";
    return t;
  }

  Map<scoreLabel, Score> get boardMap => _boardMap;

  void _updateBank(scoreLabel label, int amountOfDices) {
    _upperBank[label] = amountOfDices;
    _bankScore = _upperBank.entries.fold<int>(
        0,
        (previousValue, element) =>
            previousValue +
            element.value *
                (UPPER.firstWhere((element2) => element2 == element.key).index +
                    1));
  }

  void updateScore(scoreLabel label, int? score) {
    if (_boardMap[label]!.isSet) {
      throw Exception("Already set!, At the moment it can not be un-done!");
    }

    switch (label) {
      case scoreLabel.smallStraight:
        _boardMap[scoreLabel.smallStraight]!.score = SMALLSTRAIGHT;
        score = SMALLSTRAIGHT;
        break;
      case scoreLabel.largeStraight:
        _boardMap[scoreLabel.largeStraight]!.score = LARGESTRAIGHT;
        score = LARGESTRAIGHT;
        break;
      case scoreLabel.yatzy:
        _boardMap[scoreLabel.yatzy]!.score = YATZY;
        score = YATZY;
        hasYatzy = true;
        break;
      default:
        if (score == null) {
          throw Exception("Score cannot be null!");
        }

        if (!_boardMap[label]!.isSet) {
          if (UPPER.contains(label) && _shortCutValues.keys.contains(score)) {
            _updateBank(label, score);
            score = (label.index + 1) * _shortCutValues[score]!.toInt();
            upperScore += score;
            upperScore >= BONUSCRITERIA ? hasBonus = true : hasBonus = false;
          }

          _boardMap.update(
            label,
            (value) => value
              ..score = score
              ..isSet = true,
          );
        }
        break;
    }
    this.score += score;
  }
}

enum scoreLabel {
  ones,
  twos,
  threes,
  fours,
  fives,
  sixes,
  pairs,
  twoPairs,
  threeofaKind,
  fourofaKind,
  smallStraight,
  largeStraight,
  house,
  chance,
  yatzy,
}
