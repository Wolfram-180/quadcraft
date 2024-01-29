import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/widgets/crafting/standard_crafting_grid.dart';
import 'package:quadcraft/widgets/inventory/inventory_storage_widget.dart';

class CraftingInventory extends StatelessWidget {
  const CraftingInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalGameReference.instance.gameReference.worldData
            .craftingManager.craftingInventoryIsOpen.value
        ? const Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  InventoryStorageWidget(),
                  StandardCraftingGrid()
                ],
              ),
            ),
          )
        : Container());
  }
}
