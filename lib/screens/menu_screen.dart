import 'package:flutter/material.dart';
import 'package:flutter_flame_minecraft/screens/world_select_screen.dart';
import 'package:flutter_flame_minecraft/widgets/launcher/minecraft_button.dart';
import 'package:panorama/panorama.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Panorama(
            interactive: false,
            animSpeed: 1,
            child: Image.asset('assets/images/launcher/panorama.png'),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
/*                   ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(67, 79, 89, 0.5), BlendMode.srcATop),
                    child: Image.asset('assets/images/launcher/logo.png',
                        height: 350),
                  ), */
                  Image.asset('assets/images/launcher/logo.png', height: 350),
                  Expanded(child: Container()),
                  MinecraftButtonWidget(
                    text: 'Singleplayer',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WorldSelectScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //MinecraftButtonWidget(text: 'Multiplayer', onPressed: () {}),
                  Expanded(child: Container()),
/*                   Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'This is an expiremental game made for education. Check out the actual game- Minecraft',
                      style: TextStyle(
                          color: Colors.yellow.withOpacity(0.75),
                          fontSize: 10,
                          fontFamily: 'MinecraftFont'),
                    ),
                  ) */
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
