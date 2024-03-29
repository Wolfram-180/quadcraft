import 'package:quadcraft/global/global_game_reference.dart';
import 'package:quadcraft/global/world_data.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/items.dart';

List<Items> stoneTools = [
  Items.stoneAxe,
  Items.stonePickaxe,
  Items.stoneShovel,
];

List<Items> woodenTools = [
  Items.woodenAxe,
  Items.woodenPickaxe,
  Items.woodenShovel,
];

List<Items> ironTools = [
  Items.ironAxe,
  Items.ironPickaxe,
  Items.ironShovel,
];

List<Items> diamondTools = [
  Items.diamondAxe,
  Items.diamondPickaxe,
  Items.diamondShovel,
];

List<Items> goldTools = [
  Items.goldenAxe,
  Items.goldenPickaxe,
  Items.goldenShovel,
];

double getMiningSpeedChange(Blocks block) {
  WorldData worldData = GlobalGameReference.instance.gameReference.worldData;

  dynamic currentHeldItem = worldData
      .inventoryManager
      .inventorySlots[
          worldData.inventoryManager.currentSelectedInventorySlot.value]
      .block;

  if (currentHeldItem is Items &&
      ItemData.getItemDataForItem(currentHeldItem).toolType != Tools.none &&
      ItemData.getItemDataForItem(currentHeldItem).toolType ==
          BlockData.getBlockDataFor(block).suitableTool) {
    if (woodenTools.contains(currentHeldItem)) {
      return 0.6;
    } else if (stoneTools.contains(currentHeldItem)) {
      return 0.5;
    } else if (ironTools.contains(currentHeldItem)) {
      return 0.4;
    } else if (diamondTools.contains(currentHeldItem)) {
      return 0.27;
    } else if (goldTools.contains(currentHeldItem)) {
      return 0.23;
    } else {
      return 1;
    }
  } else {
    return 1;
  }
}
