import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quadcraft/global/crafting_manager.dart';
import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/global/inventory.dart';
import 'package:quadcraft/resources/items.dart';
import 'package:quadcraft/utils/constants.dart';
import 'package:quadcraft/utils/game_methods.dart';
import 'package:quadcraft/widgets/inventory/inventory_item_and_number.dart';
import 'package:quadcraft/widgets/inventory/inventory_slot_background.dart';

class InventorySlotWidget extends StatelessWidget {
  final SlotType slotType;
  final InventorySlot inventorySlot;
  const InventorySlotWidget(
      {Key? key, required this.slotType, required this.inventorySlot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (slotType) {
      case SlotType.itemBar:
        return GestureDetector(
          onTap: () {
            GlobalGameReference
                .instance
                .gameReference
                .worldData
                .inventoryManager
                .currentSelectedInventorySlot
                .value = inventorySlot.index;
          },
          child: getChild(),
        );

      case SlotType.inventory:
        return GestureDetector(
          onLongPress: () {
            for (int i = 0; i < inventorySlot.count.value / 2; i++) {
              GlobalGameReference
                  .instance.gameReference.worldData.inventoryManager
                  .addBlockToInventory(inventorySlot.block!);
              inventorySlot.decrementSlot();
            }
          },
          child: Draggable(
              feedback: InventoryItemAndNumberWidget(
                inventorySlot: inventorySlot,
              ),
              childWhenDragging: InventorySlotBackgroundWidget(
                slotType: slotType,
                index: inventorySlot.index,
              ),
              data: inventorySlot,
              child: getChild()),
        );

      case SlotType.crafting:
        return GestureDetector(
          onLongPress: () {
            for (int i = 0; i < inventorySlot.count.value / 2; i++) {
              GlobalGameReference
                  .instance.gameReference.worldData.inventoryManager
                  .addBlockToInventory(inventorySlot.block!);
              inventorySlot.decrementSlot();
            }
          },
          child: Draggable(
              feedback: InventoryItemAndNumberWidget(
                inventorySlot: inventorySlot,
              ),
              childWhenDragging: InventorySlotBackgroundWidget(
                slotType: slotType,
                index: inventorySlot.index,
              ),
              onDragCompleted: () {
                GlobalGameReference
                    .instance.gameReference.worldData.craftingManager
                    .checkForRecipe();
              },
              data: inventorySlot,
              child: getChild()),
        );

      case SlotType.craftingOutput:
        return GestureDetector(
          onTap: () {
            if (CraftingManager.isInPlayerInventory()) {
              int interateTill = GlobalGameReference
                  .instance
                  .gameReference
                  .worldData
                  .craftingManager
                  .playerInventoryCraftingGrid
                  .last
                  .count
                  .value;
              for (int i = 0; i < interateTill; i++) {
                if (GlobalGameReference
                    .instance.gameReference.worldData.inventoryManager
                    .addBlockToInventory(GlobalGameReference
                        .instance
                        .gameReference
                        .worldData
                        .craftingManager
                        .playerInventoryCraftingGrid[4]
                        .block!)) {
                  GlobalGameReference.instance.gameReference.worldData
                      .craftingManager.playerInventoryCraftingGrid.last
                      .decrementSlot();
                }
              }
              GlobalGameReference
                  .instance.gameReference.worldData.craftingManager
                  .decrementOneFromEachSlot(GlobalGameReference
                      .instance
                      .gameReference
                      .worldData
                      .craftingManager
                      .playerInventoryCraftingGrid);
            } else {
              int interateTill = GlobalGameReference
                  .instance
                  .gameReference
                  .worldData
                  .craftingManager
                  .standardCraftingGrid
                  .last
                  .count
                  .value;
              for (int i = 0; i < interateTill; i++) {
                if (GlobalGameReference
                    .instance.gameReference.worldData.inventoryManager
                    .addBlockToInventory(GlobalGameReference
                        .instance
                        .gameReference
                        .worldData
                        .craftingManager
                        .standardCraftingGrid
                        .last
                        .block!)) {
                  GlobalGameReference.instance.gameReference.worldData
                      .craftingManager.standardCraftingGrid.last
                      .decrementSlot();
                }
              }
              GlobalGameReference
                  .instance.gameReference.worldData.craftingManager
                  .decrementOneFromEachSlot(GlobalGameReference
                      .instance
                      .gameReference
                      .worldData
                      .craftingManager
                      .standardCraftingGrid);
            }
            GlobalGameReference.instance.gameReference.worldData.craftingManager
                .checkForRecipe();
          },
          child: getChild(),
        );
    }
  }

  Widget getChild() {
    return Stack(
      children: [
        InventorySlotBackgroundWidget(
          slotType: slotType,
          index: inventorySlot.index,
        ),
        InventoryItemAndNumberWidget(
          inventorySlot: inventorySlot,
        ),
        getDragTarget(),
      ],
    );
  }

  Widget getDragTarget() {
    return SizedBox(
      width: GameMethods.instance.slotSize,
      height: GameMethods.instance.slotSize,
      child: DragTarget(
        builder: (context, candidateData, rejectedData) => Container(),
        onAccept: (InventorySlot draggingInventorySlot) {
          if (/* slotType != SlotType.craftingOutput */ true) {
            if (inventorySlot.isEmpty) {
              inventorySlot.block = draggingInventorySlot.block;
              inventorySlot.count.value = draggingInventorySlot.count.value;

              draggingInventorySlot.emptySlot();
            } else if (draggingInventorySlot.block == inventorySlot.block &&
                draggingInventorySlot.count.value + inventorySlot.count.value <=
                    getStack(draggingInventorySlot.block)) {
              inventorySlot.count.value += draggingInventorySlot.count.value;
              draggingInventorySlot.emptySlot();
            }
          }

          if (slotType == SlotType.crafting) {
            GlobalGameReference.instance.gameReference.worldData.craftingManager
                .checkForRecipe();
          }
        },
      ),
    );
  }

  int getStack(dynamic block) {
    return (block is Items &&
            ItemData.getItemDataForItem(block).toolType != Tools.none)
        ? 1
        : stack;
  }
}
