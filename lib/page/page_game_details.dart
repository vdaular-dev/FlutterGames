import 'package:flutter/material.dart';
import 'package:flutter_games/component/item_description.dart';
import 'package:flutter_games/component/item_header_game.dart';
import 'package:flutter_games/controller/scroll_horizontal_screenshots.dart';
import 'package:flutter_games/model/game.dart';

class GameDetailsPage extends StatefulWidget {
  const GameDetailsPage(this.game, {super.key});

  final Game game;

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GameDetailHeader(widget.game),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ButtonStyle(
                    padding:
                        WidgetStateProperty.all(const EdgeInsets.all(12)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.green.shade400;
                        }
                        return null;
                      },
                    ),
                    elevation: WidgetStateProperty.all(8),
                    shadowColor: WidgetStateProperty.all(Colors.green.shade400),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.adjust,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Rent",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SizedBox(
                width: double.infinity,
                // height: double.infinity,
                child: OutlinedButton(
                  onPressed: () => {},
                  style: ButtonStyle(
                    padding:
                        WidgetStateProperty.all(const EdgeInsets.all(12)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
                    side: WidgetStateProperty.all(
                        const BorderSide(color: Colors.green, width: 4)),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.green.shade200;
                        }
                        if (states.contains(WidgetState.hovered) ||
                            states.contains(WidgetState.focused)) {
                          return Colors.white70;
                        }
                        return null;
                      },
                    ),
                    elevation: WidgetStateProperty.all(0),
                    foregroundColor: WidgetStateProperty.all(Colors.green.shade400),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.archive,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Buy",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: DescriptionText(widget.game.description)),
            HorizontalScreenshotController(widget.game.screenshots),
          ],
        ),
      ),
    );
  }
}
