import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/resources/structure.dart';
import 'package:flutter_flame_minecraft/structures/plants.dart';
import 'package:flutter_flame_minecraft/structures/trees.dart';

enum Biomes { desert, birchForest }

class BiomeData {
  final Blocks primarySoil;
  final Blocks secondarySoil;
  final List<Structure> generatingStructures;

  BiomeData(
      {required this.generatingStructures,
      required this.primarySoil,
      required this.secondarySoil});

  factory BiomeData.getBiomeDataFor(Biomes biome) {
    switch (biome) {
      case Biomes.desert:
        return BiomeData(
          primarySoil: Blocks.sand,
          secondarySoil: Blocks.sand,
          generatingStructures: [
            cactus,
          ],
        );
      case Biomes.birchForest:
        return BiomeData(
          primarySoil: Blocks.grass,
          secondarySoil: Blocks.dirt,
          generatingStructures: [
            birchTree,
          ],
        );
    }
  }
}
