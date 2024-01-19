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
    // return Vector2.all(getScreenSize().width / chunkWidth);

    return Vector2.all(30);
  }

  int get freeArea {
    return (chunkHeight * 0.2).toInt();
  }

  int get maxSecondarySoilExtent {
    return freeArea + 6;
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

  void addChunkToRightWorldChunks(List<List<Blocks?>> chunk) {
    GlobalGameReference.instance.gameReference.worldData.rightWorldChunks
        .asMap()
        .forEach((int yIndex, List<Blocks?> value) {
      GlobalGameReference
          .instance.gameReference.worldData.rightWorldChunks[yIndex]
          .addAll(value);
    });
  }
}
