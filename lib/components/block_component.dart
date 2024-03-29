import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:quadcraft/components/block_breaking_component.dart';
import 'package:quadcraft/components/item_component.dart';
import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/tools.dart';
import 'package:quadcraft/utils/game_methods.dart';

class BlockComponent extends SpriteComponent with Tappable {
  final Blocks block;
  Vector2 blockIndex;
  final int chunkIndex;

  BlockComponent(
      {required this.block,
      required this.blockIndex,
      required this.chunkIndex});

  dynamic itemDropped;

  late SpriteSheet animationBlockSpriteSheet;

  late BlockBreakingComponent blockBreakingComponent = BlockBreakingComponent()
    ..animation = animationBlockSpriteSheet.createAnimation(
        row: 0,
        stepTime: (BlockData.getBlockDataFor(block).baseMiningSpeed / 6) *
            getMiningSpeedChange(block),
        loop: false)
    ..animation!.onComplete = onBroken;

  void onBroken() {
    GameMethods.instance.replaceBlockAtWorldChunks(null, blockIndex);
    GlobalGameReference.instance.gameReference.worldData.items.add(
        ItemComponent(spawnBlockIndex: blockIndex, item: itemDropped ?? block));
    removeFromParent();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    animationBlockSpriteSheet = SpriteSheet(
      image: Flame.images
          .fromCache('sprite_sheets/blocks/block_breaking_sprite_sheet.png'),
      srcSize: Vector2.all(60),
    );

    sprite = GameMethods.instance.getSpriteFromBlock(block);
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

    if (BlockData.getBlockDataFor(block).breakable) {
      if (!blockBreakingComponent.isMounted) {
        blockBreakingComponent.animation!.reset();

        add(blockBreakingComponent);
      }
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
    if (blockBreakingComponent.isMounted) {
      remove(blockBreakingComponent);
    }

    return true;
  }
}
