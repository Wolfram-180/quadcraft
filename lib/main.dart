import 'package:flutter/material.dart';
import 'package:flutter_flame_minecraft/layout/game_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: GameLayout(),
  ));
}
