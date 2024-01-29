import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/widgets/crafting/player_inventory_crafting_grid.dart';
import 'package:quadcraft/widgets/inventory/inventory_storage_widget.dart';

class PlayerInventoryWidget extends StatelessWidget {
  const PlayerInventoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalGameReference.instance.gameReference.worldData
            .inventoryManager.inventoryIsOpen.value
        ? const Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  InventoryStorageWidget(),
                  PlayerInventoryCraftingGridWidget()
                ],
              ),
            ),
          )
        : Container());
  }
}
