import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:yatzy/models/match.dart';
import 'package:yatzy/models/player.dart';
import 'package:yatzy/widgets/player_badge.dart';

class BoardView extends StatefulWidget {
  static const ROUTE = "/Board";
  const BoardView({Key? key}) : super(key: key);

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView>
//with SingleTickerProviderStateMixin
{
  late Match _match;
  late Ticker _ticker;
  Duration _previousElapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _match = Match();

    _ticker = Ticker((elapsed) {
      setState(() {
        final diff = _previousElapsed - elapsed;
        _previousElapsed = elapsed;
        _match.elpasedTime += diff.abs();
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    super.dispose();
    _ticker.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_match.players.isEmpty) {
      assert(ModalRoute.of(context)!.settings.arguments != null);

      final players =
          ModalRoute.of(context)!.settings.arguments as List<Player>;

      _match.players.addAll(players);
    }
    _match.startMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 150,
          child: Row(
            children: [
              Text(
                "Time ${_match.elpasedTime.inMinutes}:${_match.elpasedTime.inSeconds.remainder(60)} \n Turn: ${_match.turn}",
              ),
              const Spacer(),
              _ticker.isActive
                  ? IconButton(
                      onPressed: () => setState(() {
                        _ticker.stop();
                        _previousElapsed = Duration.zero;
                      }),
                      icon: const Icon(Icons.pause),
                    )
                  : IconButton(
                      onPressed: () => setState(() {
                        _ticker.start();
                      }),
                      icon: const Icon(Icons.play_arrow),
                    ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 5 / 6,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: double.infinity,
              width: MediaQuery.of(context).size.width / 6,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all()),
                    child: const Center(
                      child: Text(
                        "Players",
                        softWrap: true,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _match.players.length,
                    itemBuilder: (context, index) {
                      var player = _match.players.elementAt(index);
                      return player.id == _match.currentPlayer!.id
                          ? PlayerBadge(
                              player: player,
                              height: 60,
                              width: double.infinity,
                              elevation: 8.0,
                            )
                          : PlayerBadge(
                              player: player,
                              height: 50,
                              width: MediaQuery.of(context).size.width / 6 * .8,
                            );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
