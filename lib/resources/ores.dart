import 'package:flutter_flame_minecraft/resources/blocks.dart';

class Ores {
  final Blocks block;
  final int rarity;

  Ores({required this.block, required this.rarity});

  static Ores ironOre = Ores(
    block: Blocks.ironOre,
    rarity: 90,
  );
  static Ores coalOre = Ores(
    block: Blocks.coalOre,
    rarity: 85,
  );
  static Ores goldOre = Ores(
    block: Blocks.goldOre,
    rarity: 70,
  );
  static Ores diamondOre = Ores(
    block: Blocks.diamondOre,
    rarity: 65,
  );
}
