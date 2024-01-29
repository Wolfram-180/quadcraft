import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quadcraft/global/world_data.dart';
import 'package:quadcraft/layout/controller_widget.dart';
import 'package:quadcraft/layout/hunger_and_health_bar.dart';
import 'package:quadcraft/layout/quit_and_save_button.dart';
import 'package:quadcraft/screens/respawn_screen.dart';
import 'package:quadcraft/utils/constants.dart';
import 'package:quadcraft/main_game.dart';
import 'package:quadcraft/widgets/crafting/crafting_inventory.dart';
import 'package:quadcraft/widgets/inventory/item_bar.dart';
import 'package:quadcraft/widgets/inventory/player_inventory.dart';

class GameLayout extends StatelessWidget {
  final int seed;
  const GameLayout({Key? key, required this.seed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //This is the main game
          GameWidget(
            game: MainGame(
              worldData: Hive.box(worldDataBox).get(seed) as WorldData,
            ),
          ),

          //Everything coming here will be in the hud
          const ControllerWidget(),
          const ItemBarWidget(),
          const HungerAndHealthBar(),
          const PlayerInventoryWidget(),
          const CraftingInventory(),
          const RespawnScreen(),
          const QuitAndSaveButton()
        ],
      ),
    );
  }
}
