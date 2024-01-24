import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_flame_minecraft/global/inventory.dart';
import 'package:flutter_flame_minecraft/global/player_data.dart';
import 'package:flutter_flame_minecraft/global/world_data.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/resources/items.dart';
import 'package:flutter_flame_minecraft/resources/sky_timer.dart';
import 'package:flutter_flame_minecraft/screens/menu_screen.dart';
import 'package:flutter_flame_minecraft/utils/constants.dart';

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

//  print(Hive.box(worldDataBox).keys);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MenuScreen(),
  ));
}
