import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_minecraft/layout/game_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // images loading
  await Flame.images
      .load('sprite_sheets/blocks/block_breaking_sprite_sheet.png');
  await Flame.images
      .load('sprite_sheets/player/player_walking_sprite_sheet.png');
  await Flame.images.load('sprite_sheets/player/player_idle_sprite_sheet.png');
  await Flame.images.load('sprite_sheets/blocks/block_sprite_sheet.png');

  runApp(const MaterialApp(
    home: GameLayout(),
  ));
}
