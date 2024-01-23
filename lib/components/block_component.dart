import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
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

  BlockBreakingComponent blockBreakingComponent = BlockBreakingComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await GameMethods.instance.getSpriteFromBlock(block);
    add(RectangleHitbox());
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize;
    position = Vector2(GameMethods.instance.blockSize.x * blockIndex.x,
        GameMethods.instance.blockSize.y * blockIndex.y);
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

    add(blockBreakingComponent);

    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    super.onTapUp(info);

    remove(BlockBreakingComponent());

    return true;
  }

  @override
  bool onTapCancel() {
    super.onTapCancel();

    // remove(BlockBreakingComponent());

    return true;
  }
}
