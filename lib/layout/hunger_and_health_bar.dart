import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_minecraft/widgets/player_health_bar.dart';
import 'package:flutter_flame_minecraft/widgets/player_hunger_bar.dart';

class HungerAndHealthBar extends StatelessWidget {
  const HungerAndHealthBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [PlayerHealthBarWidget(), PlayerHungerBarWidget()],
      ),
    );
  }
}
