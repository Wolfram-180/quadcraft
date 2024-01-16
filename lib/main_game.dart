import 'package:flame/game.dart';
import 'package:flutter_flame_minecraft/components/player_component.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/global/world_data.dart';
import 'package:get/get.dart';

class MainGame extends FlameGame {
  final WorldData worldData;

  MainGame(
      {super.children, super.world, super.camera, required this.worldData});

  GlobalGameReference globalGameReference = Get.put(GlobalGameReference());

  PlayerComponent playerComponent = PlayerComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    globalGameReference.gameReference = this;
    add(playerComponent);
  }
}
