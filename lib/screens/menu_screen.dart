import 'package:flutter/material.dart';
import 'package:quadcraft/screens/world_select_screen.dart';
import 'package:quadcraft/widgets/launcher/minecraft_button.dart';
import 'package:panorama/panorama.dart';
import 'package:just_audio/just_audio.dart';

bool isMusicPlaying = false;

// created at https://creators.aiva.ai/

final playlist = ConcatenatingAudioSource(
  children: [
    AudioSource.asset('assets/audio/track1.mp3'),
    AudioSource.asset('assets/audio/track2.mp3'),
    AudioSource.asset('assets/audio/track3.mp3'),
    AudioSource.asset('assets/audio/track4.mp3'),
    AudioSource.asset('assets/audio/track5.mp3'),
  ],
);

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isMusicPlaying) {
      final player = AudioPlayer();
      player.setAudioSource(playlist,
          initialIndex: 0, initialPosition: Duration.zero);
      player.setLoopMode(LoopMode.all);
      player.play();
      isMusicPlaying = true;
    }

    Size screenSize = MediaQuery.of(context).size;
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
                  Image.asset(
                    'assets/images/launcher/logo.png',
                    height: screenSize.height / 1.5,
                  ),
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
                  Expanded(child: Container()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
