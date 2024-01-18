import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/global/player_data.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';
import 'package:flame/game.dart';

class PlayerComponent extends SpriteAnimationComponent
    implements PositionComponent {
  final Vector2 playerDimensions = Vector2.all(60);
  final double stepTime = 0.3;
  final double speed = 5;
  bool isFacingRight = true;

  late SpriteSheet playerWalkingSpritesheet;
  late SpriteSheet playerIdleSpritesheet;

  late SpriteAnimation walkingAnimation =
      playerWalkingSpritesheet.createAnimation(row: 0, stepTime: stepTime);

  late SpriteAnimation idleAnimation =
      playerIdleSpritesheet.createAnimation(row: 0, stepTime: stepTime);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    priority = 2;

    anchor = Anchor.bottomCenter;

    playerWalkingSpritesheet = SpriteSheet(
      image: await Flame.images
          .load('sprite_sheets/player/player_walking_sprite_sheet.png'),
      srcSize: playerDimensions,
    );

    playerIdleSpritesheet = SpriteSheet(
      image: await Flame.images
          .load('sprite_sheets/player/player_idle_sprite_sheet.png'),
      srcSize: playerDimensions,
    );

    position = Vector2(100, 500);
    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic();
  }

  void movementLogic() {
    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingLeft) {
      position.x -= speed;

      if (isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = false;
      }

      animation = walkingAnimation;
    }

    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingRight) {
      position.x += speed;

      if (!isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = true;
      }
      animation = walkingAnimation;
    }

    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.idle) {
      animation = idleAnimation;
    }
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize * 1.5;
  }
}
