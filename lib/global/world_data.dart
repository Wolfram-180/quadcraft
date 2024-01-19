import 'package:flutter_flame_minecraft/global/player_data.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';

class WorldData {
  final int seed;

  WorldData({required this.seed});

  PlayerData playerData = PlayerData();

  List<List<Blocks?>> rightWorldChunks =
      List.generate(chunkHeight, (index) => []);
}
