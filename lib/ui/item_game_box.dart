import 'package:flutter/material.dart';
import 'package:flutter_games/model/game.dart';

class GameBoxItem extends StatelessWidget {
  static const imageRatio = 1.50;

  const GameBoxItem(this.buildContext, this.game, {this.width = 120, super.key});
  final BuildContext buildContext;
  final Game game;
  final double width;

  @override
  Widget build(BuildContext context) {
    double height = imageRatio * width;

    return Material(
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.hardEdge,
      elevation: 8,
      shadowColor: Color(0xCC000000),
      child: FadeInImage.assetNetwork(
        image: game.box,
        placeholder: "assets/placeholder_box.png",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
