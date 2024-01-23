import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class BlockBreakingComponent extends SpriteAnimationComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    SpriteSheet animationSpritesheet = SpriteSheet(
        image: await Flame.images
            .load('sprite_sheets/blocks/block_breaking_sprite_sheet.png'),
        srcSize: Vector2.all(60));

    animation = animationSpritesheet.createAnimation(
      row: 0,
      stepTime: 0.3,
    );

    size = GameMethods.instance.blockSize;
  }
}
