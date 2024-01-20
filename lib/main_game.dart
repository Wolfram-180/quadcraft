import 'package:flame/game.dart';
import 'package:flutter_flame_minecraft/components/block_component.dart';
import 'package:flutter_flame_minecraft/components/player_component.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/global/world_data.dart';
import 'package:flutter_flame_minecraft/utils/chunk_generation_methods.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';
import 'package:get/get.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';

class MainGame extends FlameGame {
  final WorldData worldData;

  MainGame({required this.worldData}) {
    globalGameReference.gameReference = this;
  }

  GlobalGameReference globalGameReference = Get.put(GlobalGameReference());

  PlayerComponent playerComponent = PlayerComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.followComponent(playerComponent);

    await add(playerComponent);

    GameMethods.instance.addChunkToWorldChunks(
        ChunkGenerationMethods.instance.generateChunk(-1), false);
    GameMethods.instance.addChunkToWorldChunks(
        ChunkGenerationMethods.instance.generateChunk(0), true);
    GameMethods.instance.addChunkToWorldChunks(
        ChunkGenerationMethods.instance.generateChunk(1), true);

    renderChunk(-1);
    renderChunk(0);
    renderChunk(1);
  }

  void renderChunk(int chunkIndex) {
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);

    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) {
        if (block != null) {
          add(BlockComponent(
              block: block,
              blockIndex: Vector2((chunkIndex * chunkWidth) + xIndex.toDouble(),
                  yIndex.toDouble())));
        }
      });
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    worldData.chunksThatShouldBeRendered
        .asMap()
        .forEach((int index, int chunkIndex) {
      if (!worldData.currentlyRenderedChunks.contains(chunkIndex)) {
        if (chunkIndex >= 0) {
          if (worldData.rightWorldChunks[0].length ~/ chunkWidth <
              chunkIndex + 1) {
            GameMethods.instance.addChunkToWorldChunks(
                ChunkGenerationMethods.instance.generateChunk(chunkIndex),
                true);
          }
          renderChunk(chunkIndex);

          worldData.currentlyRenderedChunks.add(chunkIndex);
        }
      }
    });
  }
}
