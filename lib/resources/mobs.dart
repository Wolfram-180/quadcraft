import 'dart:math';

import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/mobs/spider.dart';
import 'package:quadcraft/mobs/zombie.dart';
import 'package:quadcraft/resources/hostile_entity.dart';
import 'package:quadcraft/utils/constants.dart';
import 'package:quadcraft/utils/game_methods.dart';

class Mobs {
  int totalMobs = 0;

  void spawnHostileMobs() {
    if (totalMobs < mobCap) {
      GlobalGameReference.instance.gameReference.add(returnRandomHostileMob());
    } else {
      // print('mobCap full');
    }
  }

  HostileEntity returnRandomHostileMob() {
    int mobNumber = Random().nextInt(2);

    switch (mobNumber) {
      case 0:
        return Zombie(
            spawnIndexPosition: GameMethods.instance.getSpawnPositionForMob());

      case 1:
        return Spider(
            spawnIndexPosition: GameMethods.instance.getSpawnPositionForMob());

      default:
        return Zombie(
            spawnIndexPosition: GameMethods.instance.getSpawnPositionForMob());
    }
  }
}
