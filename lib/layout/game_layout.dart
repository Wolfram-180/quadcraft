import 'package:flutter/material.dart';
import 'package:flutter_flame_minecraft/layout/controller_widget.dart';
import 'package:flutter_flame_minecraft/main_game.dart';
import 'package:flame/game.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: MainGame()),
        const ControllerWidget(),
      ],
    );
  }
}
