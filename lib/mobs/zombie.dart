import 'package:flame/components.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/global/player_data.dart';
import 'package:flutter_flame_minecraft/resources/hostile_entity.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class Zombie extends HostileEntity {
  Zombie({required super.spawnIndexPosition})
      : super(
          path: "sprite_sheets/mobs/sprite_sheet_zombie.png",
          srcSize: Vector2(67, 99),
        );

  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    killEntityLogic();
    jumpingLogic();
    checkForAggrevation();
    zombieLogic(dt);
    animationLogic();
    despawnLogic();

    setAllCollisionToFalse();
  }

  void zombieLogic(double dt) {
    if (isAggrevated) {
      double playerXPosition =
          GlobalGameReference.instance.gameReference.playerComponent.position.x;

      if ((playerXPosition - position.x).abs() > 10) {
        if (position.x < playerXPosition) {
          if (!move(ComponentMotionState.walkingRight, dt,
              ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            if (canJump) {
              jump();
              canJump = false;
            }
          }
        } else {
          if (!move(ComponentMotionState.walkingLeft, dt,
              ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            if (canJump) {
              jump();
              canJump = false;
            }
          }
        }
      }
    }
  }

  @override
  void onGameResize(Vector2 newScreenSize) {
    super.onGameResize(newScreenSize);

    size = srcSize * ((GameMethods.instance.blockSize.x * 2) / srcSize.y);
  }
}
