import 'package:flutter/material.dart';
import 'package:yatzy/models/player.dart';
import 'package:yatzy/views/board_view.dart';
import 'package:yatzy/widgets/player_badge.dart';

class InitScreen extends StatefulWidget {
  static const String ROUTE = "/INDEX";
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  List<Player> players = [];

  Future<void> _addPlayer() async {
    String name = "";
    Color? color;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: const Center(child: Text("New Player")),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (name != "") {
                      setState(() {
                        players.add(Player(name, color ?? Colors.amber));
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
              content: SingleChildScrollView(
                child: ListBody(children: [
                  TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: "Name"),
                    onChanged: (t) {
                      name = t;
                    },
                  ),
                  // Add Color Picker
                ]),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          players = [
            Player("Josef"),
            Player("Vega"),
          ];
          Navigator.pushReplacementNamed(context, BoardView.ROUTE,
              arguments: players);
        },
        child: Text("Admin Quick Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the new and cool Yatzy board!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            players.isEmpty ? const SizedBox(height: 10) : _showPlayers(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _addPlayer,
              child: const Text("Add Player"),
            ),
            const SizedBox(
              height: 20,
            ),
            players.length > 1 ? _showStartGameButton() : Container(),
          ],
        ),
      ),
    );
  }

  ElevatedButton _showStartGameButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () => Navigator.pushReplacementNamed(
            context, BoardView.ROUTE,
            arguments: players),
        child: const Text(
          "Start Game",
          style: TextStyle(fontSize: 36),
        ));
  }

  SizedBox _showPlayers() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: players.length,
        itemBuilder: (ctx, i) => SizedBox(
          width: 100,
          child: PlayerBadge(
            height: 40,
            width: 90,
            player: players.elementAt(i),
            callback: (id) => setState(() {
              players.removeWhere((element) => element.id == id);
            }),
          ),
        ),
      ),
    );
  }
}
