import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quadcraft/global/inventory.dart';
import 'package:quadcraft/global/player_data.dart';
import 'package:quadcraft/global/world_data.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/items.dart';
import 'package:quadcraft/resources/sky_timer.dart';
import 'package:quadcraft/screens/menu_screen.dart';
import 'package:quadcraft/utils/constants.dart';

// dart run build_runner build --delete-conflicting-outputs

// dart run flutter_launcher_icons

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Flame.device.setLandscape();

  Hive.registerAdapter(WorldDataAdapter());
  Hive.registerAdapter(BlocksAdapter());
  Hive.registerAdapter(InventoryManagerAdapter());
  Hive.registerAdapter(InventorySlotSaveAdapter());
  Hive.registerAdapter(ItemsAdapter());
  Hive.registerAdapter(PlayerDataSaveAdapter());
  Hive.registerAdapter(SkyTimerAdapter());
  Hive.registerAdapter(SkyTimerEnumAdapter());

  await Flame.images
      .load('sprite_sheets/blocks/block_breaking_sprite_sheet.png');

  await Flame.images
      .load('sprite_sheets/player/player_walking_sprite_sheet.png');

  await Flame.images.load('sprite_sheets/player/player_idle_sprite_sheet.png');

  await Flame.images.load('sprite_sheets/blocks/block_sprite_sheet.png');

  await Flame.images.load('sprite_sheets/item/item_sprite_sheet.png');

  await Flame.images.load('sprite_sheets/mobs/sprite_sheet_zombie.png');

  await Flame.images.load('sprite_sheets/mobs/sprite_sheet_spider.png');

  await Hive.openBox(worldDataBox);

  // await Hive.box(worldDataBox).deleteFromDisk();

  // print(Hive.box(worldDataBox).keys);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MenuScreen(),
  ));
}
