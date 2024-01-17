import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame_minecraft/components/block_component.dart';
import 'package:flutter_flame_minecraft/components/player_component.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/global/world_data.dart';
import 'package:flutter_flame_minecraft/utils/chunk_generation_methods.dart';
import 'package:get/get.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';

class MainGame extends FlameGame {
  final WorldData worldData;

  MainGame(
      {super.children, super.world, super.camera, required this.worldData}) {
    globalGameReference.gameReference = this;
  }

  GlobalGameReference globalGameReference = Get.put(GlobalGameReference());

  late final CameraComponent cameraComponent;
  PlayerComponent playerComponent = PlayerComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    cameraComponent = CameraComponent(world: world);
    camera.follow(playerComponent);

    add(cameraComponent);
    add(playerComponent);
    renderChunk(ChunkGenerationMethods.instance.generateChunk());
  }

  void renderChunk(List<List<Blocks?>> chunk) {
    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) {
        if (block != null) {
          add(BlockComponent(
              block: block,
              blockIndex: Vector2(xIndex.toDouble(), yIndex.toDouble())));
        }
      });
    });
  }
}
