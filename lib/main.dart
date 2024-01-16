import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_minecraft/main_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GameWidget(game: MainGame()));
}
