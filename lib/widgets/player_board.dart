import 'package:flutter/material.dart';
import 'package:yatzy/widgets/player_badge.dart';
import 'package:yatzy/models/match.dart';

class PlayerBoard extends StatelessWidget {
  const PlayerBoard({
    Key? key,
    required Match match,
  })  : _match = match,
        super(key: key);

  final Match _match;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border.symmetric(vertical: BorderSide()),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              "Players",
              softWrap: true,
              style: TextStyle(fontSize: 24),
            ),
          ),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _match.players.length,
            itemBuilder: (context, index) {
              var player = _match.players.elementAt(index);
              return player.id == _match.currentPlayer!.id
                  ? PlayerBadge.extended(
                      player: player,
                      height: 60,
                      width: double.infinity,
                      elevation: 8.0,
                    )
                  : PlayerBadge.extended(
                      player: player,
                      height: 50,
                      width: MediaQuery.of(context).size.width / 6 * .8,
                    );
            },
          ),
        ],
      ),
    );
  }
}
