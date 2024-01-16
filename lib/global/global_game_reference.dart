import 'package:flutter_flame_minecraft/main_game.dart';
import 'package:get/get.dart';

class GlobalGameReference {
  late MainGame gameReference;

  static GlobalGameReference get instance => Get.put(GlobalGameReference());
}
