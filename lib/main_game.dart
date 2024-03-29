import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quadcraft/components/item_component.dart';
import 'package:quadcraft/components/player_component.dart';
import 'package:quadcraft/components/sky_component.dart';
import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/global/player_data.dart';
import 'package:quadcraft/global/world_data.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/foods.dart';
import 'package:quadcraft/resources/items.dart';
import 'package:quadcraft/resources/sky_timer.dart';
import 'package:quadcraft/utils/chunk_generation_methods.dart';
import 'package:quadcraft/utils/constants.dart';
import 'package:quadcraft/utils/game_methods.dart';

class MainGame extends FlameGame
    with HasCollisionDetection, HasTappables, HasKeyboardHandlerComponents {
  final WorldData worldData;

  MainGame({required this.worldData}) {
    globalGameReference.gameReference = this;
  }

  GlobalGameReference globalGameReference = Get.put(GlobalGameReference());

  PlayerComponent playerComponent = PlayerComponent();

  SkyComponent skyComponent = SkyComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(playerComponent);

    add(skyComponent);
  }

  void renderChunk(int chunkIndex) {
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);

    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) {
        if (block != null) {
          add(BlockData.getParentForBlock(
              block,
              Vector2((chunkIndex * chunkWidth) + xIndex.toDouble(),
                  yIndex.toDouble()),
              chunkIndex));
        }
      });
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    worldData.skyTimer.updateTimer(dt);

    itemRenderingLogic();

    if (worldData.skyTimer.skyTime == SkyTimerEnum.night) {
      worldData.mobs.spawnHostileMobs();
    }

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
        } else {
          if (worldData.leftWorldChunks[0].length ~/ chunkWidth <
              chunkIndex.abs()) {
            GameMethods.instance.addChunkToWorldChunks(
                ChunkGenerationMethods.instance.generateChunk(chunkIndex),
                false);
          }

          renderChunk(chunkIndex);

          worldData.currentlyRenderedChunks.add(chunkIndex);
        }
      }
    });
  }

  void itemRenderingLogic() {
    worldData.items.asMap().forEach((int index, ItemComponent item) {
      if (!item.isMounted) {
        if (worldData.chunksThatShouldBeRendered.contains(GameMethods.instance
            .getChunkIndexFromPositionIndex(item.spawnBlockIndex))) {
          add(item);
        }
      } else {
        if (!worldData.chunksThatShouldBeRendered.contains(GameMethods.instance
            .getChunkIndexFromPositionIndex(item.spawnBlockIndex))) {
          remove(item);
        }
      }
    });
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);

    Vector2 blockPlacingPosition = GameMethods.instance
        .getIndexPositionFromPixels(info.eventPosition.game);

    placeBlockLogic(blockPlacingPosition);

    eatingLogic();
  }

  void eatingLogic() {
    dynamic currentItem = worldData
        .inventoryManager
        .inventorySlots[
            worldData.inventoryManager.currentSelectedInventorySlot.value]
        .block;

    if (currentItem is Items &&
        ItemData.getItemDataForItem(currentItem).isEatable) {
      playerComponent.changeHungerBy(getFoodPointsForFood[currentItem] ?? 0);
      worldData
          .inventoryManager
          .inventorySlots[
              worldData.inventoryManager.currentSelectedInventorySlot.value]
          .decrementSlot();
    }
  }

  void placeBlockLogic(Vector2 blockPlacingPosition) {
    if (blockPlacingPosition.y > 0 &&
        blockPlacingPosition.y < chunkHeight &&
        GameMethods.instance.playerIsWithinRange(blockPlacingPosition) &&
        GameMethods.instance.getBlockAtIndexPosition(blockPlacingPosition) ==
            null &&
        GameMethods.instance.adjacentBlocksExist(blockPlacingPosition) &&
        worldData
                .inventoryManager
                .inventorySlots[worldData
                    .inventoryManager.currentSelectedInventorySlot.value]
                .block !=
            null &&
        GameMethods.instance.adjacentBlocksExist(blockPlacingPosition) &&
        worldData
            .inventoryManager
            .inventorySlots[
                worldData.inventoryManager.currentSelectedInventorySlot.value]
            .block is Blocks) {
      GameMethods.instance.replaceBlockAtWorldChunks(
          worldData
              .inventoryManager
              .inventorySlots[
                  worldData.inventoryManager.currentSelectedInventorySlot.value]
              .block as Blocks,
          blockPlacingPosition);

      add(BlockData.getParentForBlock(
          worldData
              .inventoryManager
              .inventorySlots[
                  worldData.inventoryManager.currentSelectedInventorySlot.value]
              .block! as Blocks,
          blockPlacingPosition,
          GameMethods.instance
              .getChunkIndexFromPositionIndex(blockPlacingPosition)));

      worldData
          .inventoryManager
          .inventorySlots[
              worldData.inventoryManager.currentSelectedInventorySlot.value]
          .decrementSlot();
    }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      worldData.playerData.componentMotionState =
          ComponentMotionState.walkingRight;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      worldData.playerData.componentMotionState =
          ComponentMotionState.walkingLeft;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      worldData.playerData.componentMotionState = ComponentMotionState.jumping;
    }

    if (keysPressed.isEmpty) {
      worldData.playerData.componentMotionState = ComponentMotionState.idle;
    }

    return KeyEventResult.ignored;
  }
}
