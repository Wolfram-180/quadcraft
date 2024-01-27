import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_flame_minecraft/components/player_component.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/utils/game_methods.dart';
import 'package:flutter_flame_minecraft/widgets/launcher/minecraft_button.dart';

class RespawnScreen extends StatelessWidget {
  const RespawnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = GameMethods.instance.getScreenSize();
    return Obx(() {
      if (GlobalGameReference
          .instance.gameReference.worldData.playerData.playerIsDead.value) {
        GlobalGameReference.instance.gameReference.pauseEngine();

        return Container(
          width: screenSize.width,
          height: screenSize.height,
          color: Colors.red.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You died!',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontFamily: 'MinecraftFont',
                  shadows: [
                    BoxShadow(color: Colors.black, offset: Offset(3, 3))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: MinecraftButtonWidget(
                  text: 'Respawn',
                  onPressed: () {
                    GlobalGameReference.instance.gameReference.worldData
                        .playerData.playerIsDead.value = false;

                    GlobalGameReference.instance.gameReference.resumeEngine();

                    GlobalGameReference.instance.gameReference.playerComponent =
                        PlayerComponent();

                    GlobalGameReference.instance.gameReference.add(
                        GlobalGameReference
                            .instance.gameReference.playerComponent);

                    GlobalGameReference.instance.gameReference.worldData
                        .playerData.playerHunger.value = 10;
                  },
                ),
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
