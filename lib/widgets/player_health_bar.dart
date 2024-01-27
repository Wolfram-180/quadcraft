import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';

class PlayerHealthBarWidget extends StatelessWidget {
  const PlayerHealthBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> children = [];

      for (int i = 10; i > 0; i--) {
        bool isFullHeart = false;

        if (GlobalGameReference.instance.gameReference.worldData.playerData
                .playerHealth.value >=
            i) {
          isFullHeart = true;
        }

        children.add(getHeartWidget(isFullHeart));
      }

      return Row(children: children);
    });
  }

  //Heart Widget
  Widget getHeartWidget(bool fullHeart) {
    double width = GameMethods.instance.getScreenSize().width / 30;
    return SizedBox(
      width: width,
      height: width,
      child: FittedBox(
        child: Stack(
          children: [
            Image.asset('assets/images/gui/empty_heart.png'),
            fullHeart
                ? Image.asset('assets/images/gui/full_heart.png')
                : Container(),
          ],
        ),
      ),
    );
  }
}
