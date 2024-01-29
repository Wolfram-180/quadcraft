import 'package:flame/input.dart';
import 'package:quadcraft/components/block_component.dart';
import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/global/inventory.dart';
import 'package:quadcraft/resources/blocks.dart';

class CraftingTableBlock extends BlockComponent {
  CraftingTableBlock({required super.chunkIndex, required super.blockIndex})
      : super(block: Blocks.craftingTable);

  InventoryManager inventoryManager =
      GlobalGameReference.instance.gameReference.worldData.inventoryManager;

  @override
  bool onTapDown(TapDownInfo info) {
    if (inventoryManager
            .inventorySlots[inventoryManager.currentSelectedInventorySlot.value]
            .block ==
        null) {
      GlobalGameReference.instance.gameReference.worldData.craftingManager
          .craftingInventoryIsOpen.value = true;
    } else {
      super.onTapDown(info);
    }

    return true;
  }
}
