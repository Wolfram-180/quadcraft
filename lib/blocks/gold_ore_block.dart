import 'package:flutter_flame_minecraft/components/block_component.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/resources/items.dart';

class GoldOreBlock extends BlockComponent {
  GoldOreBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.goldOre);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    itemDropped = Items.goldIngot;
  }
}
