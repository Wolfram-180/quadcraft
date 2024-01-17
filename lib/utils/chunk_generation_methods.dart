import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';

class ChunkGenerationMethods {
  static ChunkGenerationMethods get instance => ChunkGenerationMethods();

  List<List<Blocks?>> generateNullChunk() {
    return List.generate(
        chunkHeight, (index) => List.generate(chunkWidth, (index) => null));
  }

  List<List<Blocks?>> generateChunk() {
    List<List<Blocks?>> chunk = generateNullChunk();

    chunk.asMap().forEach((int indOfRowOfBlocks, List<Blocks?> rowOfBlocks) {
      if (indOfRowOfBlocks == 5) {
        rowOfBlocks.asMap().forEach((int index, Blocks? value) {
          chunk[5][index] = Blocks.grass;
        });
      }
      if (indOfRowOfBlocks >= 6) {
        rowOfBlocks.asMap().forEach((int index, Blocks? value) {
          chunk[indOfRowOfBlocks][index] = Blocks.dirt;
        });
      }
    });

    return chunk;
  }
}
