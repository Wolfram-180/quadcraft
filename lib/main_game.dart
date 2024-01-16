import 'package:flame/game.dart';
import 'package:flutter_flame_minecraft/components/player_component.dart';

class MainGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(PlayerComponent());
  }
}
