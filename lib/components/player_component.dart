import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/global/player_data.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class PlayerComponent extends SpriteAnimationComponent with CollisionCallbacks {
  final Vector2 playerDimensions = Vector2.all(60);
  final double stepTime = 0.3;
  final double speed = 5;
  bool isFacingRight = true;
  double yVelocity = 0;

  late SpriteSheet playerWalkingSpritesheet;
  late SpriteSheet playerIdleSpritesheet;

  late SpriteAnimation walkingAnimation =
      playerWalkingSpritesheet.createAnimation(row: 0, stepTime: stepTime);

  late SpriteAnimation idleAnimation =
      playerIdleSpritesheet.createAnimation(row: 0, stepTime: stepTime);

  bool isCollidingBottom = false;
  bool isCollidingLeft = false;
  bool isCollidingRight = false;

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollision(intersectionPoints, other);

    intersectionPoints.forEach(
      (Vector2 individualIntersectionPoint) {
        if (individualIntersectionPoint.y > (position.y - (size.y * 0.3)) &&
            (intersectionPoints.first.x - intersectionPoints.last.x).abs() >
                size.x * 0.4) {
          isCollidingBottom = true;
        }

        if (individualIntersectionPoint.y < (position.y - (size.y * 0.3))) {
          if (individualIntersectionPoint.x > position.x) {
            isCollidingRight = true;
          } else {
            isCollidingLeft = true;
          }
        }
      },
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

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

    position = Vector2(50, 200);

    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic();

    if (!isCollidingBottom) {
      if (yVelocity < gravity * 5) {
        position.y += yVelocity;
        yVelocity += gravity;
      } else {
        position.y += yVelocity;
      }
    }

    isCollidingBottom = false;
    isCollidingRight = false;
    isCollidingLeft = false;
  }

  void movementLogic() {
    if (GlobalGameReference.instance.gameReference.worldData.playerData
                .componentMotionState ==
            ComponentMotionState.walkingLeft &&
        !isCollidingLeft) {
      position.x -= speed;

      if (isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = false;
      }

      animation = walkingAnimation;
    }

    if (GlobalGameReference.instance.gameReference.worldData.playerData
                .componentMotionState ==
            ComponentMotionState.walkingRight &&
        !isCollidingRight) {
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
