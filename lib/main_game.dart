import 'package:flame/game.dart';
import 'package:flutter_flame_minecraft/components/player_component.dart';
import 'package:flutter_flame_minecraft/global/world_data.dart';

class MainGame extends FlameGame {
  final WorldData worldData;

  MainGame(
      {super.children, super.world, super.camera, required this.worldData});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(PlayerComponent());
  }
}
