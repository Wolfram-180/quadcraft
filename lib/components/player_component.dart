import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter_flame_minecraft/components/block_component.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/global/player_data.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class PlayerComponent extends SpriteAnimationComponent with CollisionCallbacks {
  final Vector2 playerDimensions = Vector2.all(60);
  final double stepTime = 0.3;

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
  bool isCollidingTop = false;

  double jumpForce = 0;

  double localPlayerSpeed = 0;
  bool refreshSpeed = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is BlockComponent &&
        BlockData.getBlockDataFor(other.block).isCollidable) {
      intersectionPoints.forEach(
        (Vector2 individualIntersectionPoint) {
          // bottom collision
          if (individualIntersectionPoint.y > (position.y - (size.y * 0.3)) &&
              (intersectionPoints.first.x - intersectionPoints.last.x).abs() >
                  size.x * 0.4) {
            isCollidingBottom = true;
            yVelocity = 0;
          }

          // top collision
          if ((individualIntersectionPoint.y <
                  (position.y - (size.y * 0.75))) &&
              ((intersectionPoints.first.x - intersectionPoints.last.x).abs() >
                  size.x * 0.4) &&
              (jumpForce > 0)) {
            isCollidingTop = true;
          }

          // sides collision
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
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    priority = 2;

    anchor = Anchor.bottomCenter;

    playerWalkingSpritesheet = SpriteSheet(
      image: Flame.images
          .fromCache('sprite_sheets/player/player_walking_sprite_sheet.png'),
      srcSize: playerDimensions,
    );

    playerIdleSpritesheet = SpriteSheet(
      image: Flame.images
          .fromCache('sprite_sheets/player/player_idle_sprite_sheet.png'),
      srcSize: playerDimensions,
    );

    position = Vector2(50, 50);

    animation = idleAnimation;

    add(TimerComponent(
        period: 1,
        repeat: true,
        onTick: () {
          refreshSpeed = true;
        }));
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic(dt);
    fallingLogic(dt);
    jumpingLogic();
    setAllCollisionToFalse();

    if (refreshSpeed) {
      localPlayerSpeed = (playerSpeed * GameMethods.instance.blockSize.x) * dt;
      refreshSpeed = false;
    }
  }

  void jumpingLogic() {
    if (jumpForce > 0) {
      position.y -= jumpForce;
      jumpForce -= GameMethods.instance.blockSize.x * 0.15;
      if (isCollidingTop) {
        jumpForce = 0;
        isCollidingTop = false;
      }
    }
  }

  void fallingLogic(double dt) {
    if (!isCollidingBottom) {
      if (yVelocity < (GameMethods.instance.gravity * dt) * 10) {
        position.y += yVelocity;
        yVelocity += GameMethods.instance.gravity * dt;
      } else {
        position.y += yVelocity;
      }
    }
  }

  void setAllCollisionToFalse() {
    isCollidingBottom = false;
    isCollidingRight = false;
    isCollidingLeft = false;
    isCollidingTop = false;
  }

  void move(ComponentMotionState componentMotionState, double dt) {
    switch (componentMotionState) {
      case ComponentMotionState.walkingLeft:
        if (!isCollidingLeft) {
          position.x -= localPlayerSpeed;
          if (isFacingRight) {
            flipHorizontallyAroundCenter();
            isFacingRight = false;
          }

          animation = walkingAnimation;
        }
        break;
      case ComponentMotionState.walkingRight:
        if (!isCollidingRight) {
          position.x += localPlayerSpeed;
          if (!isFacingRight) {
            flipHorizontallyAroundCenter();
            isFacingRight = true;
          }
          animation = walkingAnimation;
        }
        break;
      case ComponentMotionState.idle:
        break;
      default:
        break;
    }
  }

  void movementLogic(double dt) {
    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingLeft) {
      move(ComponentMotionState.walkingLeft, dt);
    }

    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingRight) {
      move(ComponentMotionState.walkingRight, dt);
    }

    if (GlobalGameReference
            .instance.gameReference.worldData.playerData.componentMotionState ==
        ComponentMotionState.idle) {
      animation = idleAnimation;
    }

    if (GlobalGameReference.instance.gameReference.worldData.playerData
                .componentMotionState ==
            ComponentMotionState.jumping &&
        isCollidingBottom) {
      jumpForce = GameMethods.instance.blockSize.x * 0.6;
      // animation = idleAnimation;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    size = GameMethods.instance.blockSize * 1.5;
  }
}
