import 'package:flutter/material.dart';
import 'package:yatzy/models/player.dart';

class PlayerBadge extends StatelessWidget {
  const PlayerBadge.extended(
      {Key? key,
      required this.player,
      this.callback,
      required this.height,
      required this.width,
      this.elevation})
      : _extended = true,
        super(key: key);

  const PlayerBadge.disposable({
    Key? key,
    required this.player,
    this.callback,
    required this.height,
    required this.width,
    this.elevation,
  })  : _extended = false,
        super(key: key);

  final Player player;
  final Function? callback;
  final double height, width;
  final double? elevation;
  final bool _extended;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: width,
            height: height,
            child: Card(
              color: player.color,
              elevation: elevation,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Center(
                child: Text(
                  "${player.name} ${_extended ? player.board.score : ""}",
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
        callback != null
            ? Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  splashRadius: .5,
                  tooltip: "Deletes the user",
                  onPressed: () => callback!(player.id),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
