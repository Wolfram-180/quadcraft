import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame_minecraft/components/block_component.dart';
import 'package:flutter_flame_minecraft/components/player_component.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/resources/entity.dart';
import 'package:flutter_flame_minecraft/resources/items.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class ItemComponent extends Entity {
  final Vector2 spawnBlockIndex;
  final dynamic item;

  ItemComponent({required this.spawnBlockIndex, required this.item});

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BlockComponent &&
        BlockData.getBlockDataFor(other.block).isCollidable) {
      super.onCollision(intersectionPoints, other);

      //player collided with the item
    } else if (other is PlayerComponent) {
      if (GlobalGameReference.instance.gameReference.worldData.inventoryManager
          .addBlockToInventory(item)) {
        GlobalGameReference.instance.gameReference.worldData.items.remove(this);
        removeFromParent();
      }
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    position = (spawnBlockIndex * GameMethods.instance.blockSize.x) +
        GameMethods.instance.blockSize / 4;
    animation = SpriteAnimation.spriteList([
      item is Blocks
          ? GameMethods.instance.getSpriteFromBlock(item as Blocks)
          : GameMethods.instance.getSpriteFromItem(item as Items)
    ], stepTime: 1);
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    size = GameMethods.instance.blockSize * 0.6;
  }

  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    setAllCollisionToFalse();
  }
}
