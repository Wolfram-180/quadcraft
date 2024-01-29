import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/screens/menu_screen.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';
import 'dart:io';

class QuitAndSaveButton extends StatelessWidget {
  const QuitAndSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {
              //saving world
              Future.delayed(const Duration(milliseconds: 100)).then(
                (_) async {
                  await Hive.box(worldDataBox)
                      .put(
                          GlobalGameReference
                              .instance.gameReference.worldData.seed,
                          GlobalGameReference.instance.gameReference.worldData)
                      .then(
                    (_) {
                      if (Platform.isAndroid) {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      } else if (Platform.isWindows) {
                        exit(0);
                      }
/*                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuScreen(),
                    ),
                  ); */
                    },
                  );
                },
              );
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.grey[800]!,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
