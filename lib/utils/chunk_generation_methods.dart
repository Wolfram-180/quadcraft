import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/resources/biomes.dart';
import 'package:flutter_flame_minecraft/resources/structure.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class ChunkGenerationMethods {
  static ChunkGenerationMethods get instance => ChunkGenerationMethods();

  List<List<Blocks?>> generateNullChunk() {
    return List.generate(
        chunkHeight, (index) => List.generate(chunkWidth, (index) => null));
  }

  List<List<Blocks?>> generateChunk(int chunkIndex) {
    Biomes biome = Random().nextBool() ? Biomes.desert : Biomes.birchForest;

    List<List<Blocks?>> chunk = generateNullChunk();

    List<List<double>> rawNoise = noise2(
      chunkIndex >= 0
          ? chunkWidth * (chunkIndex + 1)
          : chunkWidth * (chunkIndex.abs()),
      1,
      noiseType: NoiseType.perlin,
      frequency: 0.05,
      seed: chunkIndex >= 0
          ? GlobalGameReference.instance.gameReference.worldData.seed
          : GlobalGameReference.instance.gameReference.worldData.seed + 1,
    );

    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    yValues.removeRange(
        0,
        chunkIndex >= 0
            ? chunkWidth * chunkIndex
            : chunkWidth * (chunkIndex.abs() - 1));

    chunk = generatePrimarySoil(chunk, yValues, biome);

    chunk = generateSecondarySoil(chunk, yValues, biome);

    chunk = generateStone(chunk);

    chunk = addStructuresToChunk(chunk, yValues);

    return chunk;
  }

  List<List<Blocks?>> generatePrimarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    yValues.asMap().forEach((int index, int value) {
      chunk[value][index] = BiomeData.getBiomeDataFor(biome).primarySoil;
    });
    return chunk;
  }

  List<List<Blocks?>> generateSecondarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    yValues.asMap().forEach((int index, int value) {
      for (int i = value + 1;
          i <= value + GameMethods.instance.maxSecondarySoilExtent;
          i++) {
        chunk[i][index] = BiomeData.getBiomeDataFor(biome).secondarySoil;
      }
    });
    return chunk;
  }

  List<List<Blocks?>> generateStone(List<List<Blocks?>> chunk) {
    for (int index = 0; index < chunkWidth; index++) {
      for (int i = GameMethods.instance.maxSecondarySoilExtent + 1;
          i < chunk.length;
          i++) {
        chunk[i][index] = Blocks.stone;
      }
    }

    int x1 = Random().nextInt(chunkWidth ~/ 2);
    int x2 = x1 + Random().nextInt(chunkWidth ~/ 2);

    chunk[GameMethods.instance.maxSecondarySoilExtent]
        .fillRange(x1, x2, Blocks.stone);

    return chunk;
  }

  List<List<Blocks?>> addStructuresToChunk(
      List<List<Blocks?>> chunk, List<int> yValues) {
    int xPositionOfStructure =
        Random().nextInt(chunkWidth - treeStructure.maxWidth);

    int yPositionOfStructure = yValues[xPositionOfStructure];

    for (int indexOfRow = 0;
        indexOfRow < treeStructure.structure.length;
        indexOfRow++) {
      List<Blocks?> rowOfBlocksInStructure =
          treeStructure.structure[indexOfRow];
      rowOfBlocksInStructure
          .asMap()
          .forEach((int index, Blocks? blockInSructure) {
        chunk[yPositionOfStructure - indexOfRow][xPositionOfStructure + index] =
            blockInSructure;
      });
    }

    return chunk;
  }

  List<int> getYValuesFromRawNoise(List<List<double>> rawNoise) {
    List<int> yValues = [];

    rawNoise.asMap().forEach((int index, List<double> value) {
      yValues
          .add((value[0] * 10).toInt().abs() + GameMethods.instance.freeArea);
    });

    return yValues;
  }
}
