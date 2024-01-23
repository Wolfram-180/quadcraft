import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_flame_minecraft/global/global_game_reference.dart';
import 'package:flutter_flame_minecraft/widgets/crafting/standard_crafting_grid.dart';
import 'package:flutter_flame_minecraft/widgets/inventory/inventory_storage_widget.dart';

class CraftingInventory extends StatelessWidget {
  const CraftingInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalGameReference.instance.gameReference.worldData
            .craftingManager.craftingInventoryIsOpen.value
        ? Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: const [
                  InventoryStorageWidget(),
                  StandardCraftingGrid()
                ],
              ),
            ),
          )
        : Container());
  }
}
