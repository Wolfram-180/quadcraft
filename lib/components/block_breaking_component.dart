import 'package:flame/components.dart';
import 'package:quadcraft/utils/game_methods.dart';

class BlockBreakingComponent extends SpriteAnimationComponent {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    size = GameMethods.instance.blockSize;
  }
}
