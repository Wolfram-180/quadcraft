import 'package:fast_noise/fast_noise.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class ChunkGenerationMethods {
  static ChunkGenerationMethods get instance => ChunkGenerationMethods();

  List<List<Blocks?>> generateNullChunk() {
    return List.generate(
        chunkHeight, (index) => List.generate(chunkWidth, (index) => null));
  }

  List<List<Blocks?>> generateChunk() {
    List<List<Blocks?>> chunk = generateNullChunk();

    List<List<double>> rawNoise = noise2(chunkWidth, 1,
        noiseType: NoiseType.perlin, frequency: 0.05, seed: 98765493);

    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    chunk = generatePrimarySoil(chunk, yValues, Blocks.grass);

    chunk = generateSecondarySoil(chunk, yValues, Blocks.dirt);

    chunk = generateStone(chunk);

    return chunk;
  }

  List<List<Blocks?>> generatePrimarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Blocks block) {
    yValues.asMap().forEach((int index, int value) {
      chunk[value][index] = block;
    });
    return chunk;
  }

  List<List<Blocks?>> generateSecondarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Blocks block) {
    yValues.asMap().forEach((int index, int value) {
      for (int i = value + 1;
          i <= value + GameMethods.instance.maxSecondarySoilExtent;
          i++) {
        chunk[i][index] = block;
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
