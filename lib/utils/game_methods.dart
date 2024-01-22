import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';

class GameMethods {
  static GameMethods get instance => GameMethods();

  Vector2 get blockSize {
    return Vector2.all(getScreenSize().width / chunkWidth);

    // return Vector2.all(30);
  }

  int get freeArea {
    return (chunkHeight * 0.4).toInt();
  }

  int get maxSecondarySoilExtent {
    return freeArea + 6;
  }

  double get playerXIndexPosition {
    return GlobalGameReference
            .instance.gameReference.playerComponent.position.x /
        blockSize.x;
  }

  double get playerYIndexPosition {
    return GlobalGameReference
            .instance.gameReference.playerComponent.position.y /
        blockSize.x;
  }

  int get currentChunkPlayerIndex {
    return playerXIndexPosition >= 0
        ? playerXIndexPosition ~/ chunkWidth
        : (playerXIndexPosition ~/ chunkWidth) - 1;
  }

  double get gravity {
    return blockSize.x * 0.8;
  }

  int getChunkIndexFromPositionIndex(Vector2 positionIndex) {
    return positionIndex.x >= 0
        ? positionIndex.x ~/ chunkWidth
        : (positionIndex.x ~/ chunkWidth) - 1;
  }

  Vector2 getIndexPositionFromPixels(Vector2 clickPosition) {
    return Vector2(
      (clickPosition.x / blockSize.x).floorToDouble(),
      (clickPosition.y / blockSize.x).floorToDouble(),
    ); //------------------------- x not y (?)
  }

  Size getScreenSize() {
    return MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
  }

  Future<SpriteSheet> getBlockSpriteSheet() async {
    return SpriteSheet(
        image: await Flame.images
            .load('sprite_sheets/blocks/block_sprite_sheet.png'),
        srcSize: Vector2.all(60));
  }

  Future<Sprite> getSpriteFromBlock(Blocks block) async {
    SpriteSheet spriteSheet = await getBlockSpriteSheet();
    return spriteSheet.getSprite(0, block.index);
  }

  void addChunkToWorldChunks(
      List<List<Blocks?>> chunk, bool isInRightWorldChunks) {
    if (isInRightWorldChunks) {
      chunk.asMap().forEach((int yIndex, List<Blocks?> value) {
        GlobalGameReference
            .instance.gameReference.worldData.rightWorldChunks[yIndex]
            .addAll(value);
      });
    } else {
      chunk.asMap().forEach((int yIndex, List<Blocks?> value) {
        GlobalGameReference
            .instance.gameReference.worldData.leftWorldChunks[yIndex]
            .addAll(value);
      });
    }
  }

  List<List<Blocks?>> getChunk(int chunkIndex) {
    List<List<Blocks?>> chunk = [];
    if (chunkIndex >= 0) {
      GlobalGameReference.instance.gameReference.worldData.rightWorldChunks
          .asMap()
          .forEach((int index, List<Blocks?> rowOfBlocks) {
        chunk.add(rowOfBlocks.sublist(
            chunkWidth * chunkIndex, chunkWidth * (chunkIndex + 1)));
      });
    } else {
      GlobalGameReference.instance.gameReference.worldData.leftWorldChunks
          .asMap()
          .forEach((int index, List<Blocks?> rowOfBlocks) {
        chunk.add(rowOfBlocks
            .sublist(chunkWidth * (chunkIndex.abs() - 1),
                chunkWidth * chunkIndex.abs())
            .reversed
            .toList());
      });
    }
    return chunk;
  }

  List<List<int>> processNoise(List<List<double>> rawNoise) {
    List<List<int>> processedNoise = List.generate(
      rawNoise.length,
      (index) => List.generate(rawNoise[0].length, (index) => 255),
    );

    for (var x = 0; x < rawNoise.length; x++) {
      for (var y = 0; y < rawNoise[0].length; y++) {
        int value = (0x80 + 0x80 * rawNoise[x][y]).floor();
        processedNoise[x][y] = value;
      }
    }

    return processedNoise;
  }

  void replaceBlockAtWorldChunks(Blocks? block, Vector2 blockIndex) {
    // right chunks
    if (blockIndex.x >= 0) {
      GlobalGameReference.instance.gameReference.worldData
          .rightWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt()] = block;
    } else
    // left chunks
    {
      GlobalGameReference.instance.gameReference.worldData
              .leftWorldChunks[blockIndex.y.toInt()]
          [blockIndex.x.toInt().abs() - 1] = block;
    }
  }

  bool playerIsWithinRange(Vector2 positionIndex) {
    if ((positionIndex.x - playerXIndexPosition).abs() <= maxReach &&
        (positionIndex.y - playerYIndexPosition).abs() <= maxReach) {
      return true;
    }

    return false;
  }

  Blocks? getBlockAtIndexPosition(Vector2 blockIndex) {
    // right chunks
    if (blockIndex.x >= 0) {
      return GlobalGameReference.instance.gameReference.worldData
          .rightWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt()];
    } else
    // left chunks
    {
      return GlobalGameReference.instance.gameReference.worldData
              .leftWorldChunks[blockIndex.y.toInt()]
          [blockIndex.x.toInt().abs() - 1];
    }
  }
}
