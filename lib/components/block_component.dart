import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_flame_minecraft/components/block_breaking_component.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';

class BlockComponent extends SpriteComponent with Tappable {
  final Blocks block;
  final Vector2 blockIndex;
  final int chunkIndex;

  BlockComponent(
      {required this.chunkIndex,
      required this.block,
      required this.blockIndex});

  late SpriteSheet animationBlockSpriteSheet;

  late BlockBreakingComponent blockBreakingComponent = BlockBreakingComponent()
    ..animation = animationBlockSpriteSheet.createAnimation(
        row: 0, stepTime: 0.3, loop: false)
    ..animation!.onComplete = () {
      GameMethods.instance.replaceBlockAtWorldChunks(null, blockIndex);
      removeFromParent();
    };

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    animationBlockSpriteSheet = SpriteSheet(
        image: await Flame.images
            .load('sprite_sheets/blocks/block_breaking_sprite_sheet.png'),
        srcSize: Vector2.all(60));

    sprite = await GameMethods.instance.getSpriteFromBlock(block);
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize;
    position = Vector2(GameMethods.instance.blockSize.x * blockIndex.x,
        GameMethods.instance.blockSize.x * blockIndex.y);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!GlobalGameReference
        .instance.gameReference.worldData.chunksThatShouldBeRendered
        .contains(chunkIndex)) {
      removeFromParent();

      GlobalGameReference
          .instance.gameReference.worldData.currentlyRenderedChunks
          .remove(chunkIndex);
    }
  }

  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    if (!blockBreakingComponent.isMounted) {
      blockBreakingComponent.animation!.reset();
      add(blockBreakingComponent);
    }

    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    super.onTapUp(info);

    if (blockBreakingComponent.isMounted) {
      remove(blockBreakingComponent);
    }

    return true;
  }

  @override
  bool onTapCancel() {
    super.onTapCancel();

    if (blockBreakingComponent.isMounted) {
      remove(blockBreakingComponent);
    }

    return true;
  }
}
