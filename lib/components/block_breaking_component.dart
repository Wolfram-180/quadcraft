import 'package:flame/components.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class BlockBreakingComponent extends SpriteAnimationComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = GameMethods.instance.blockSize;
  }
}
