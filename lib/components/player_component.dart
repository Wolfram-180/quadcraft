import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';

class PlayerComponent extends SpriteAnimationComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    SpriteSheet playerSpriteSheet = SpriteSheet(
      image: await Flame.images
          .load('sprite_sheets/player/player_walking_sprite_sheet.png'),
      srcSize: Vector2(60, 60),
    );

    animation = playerSpriteSheet.createAnimation(row: 0, stepTime: 0.1);
    size = Vector2(100, 100);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(1, 0) * dt * 100;
  }
}
