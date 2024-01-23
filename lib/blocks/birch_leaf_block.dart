import 'dart:math';

import 'package:flutter_flame_minecraft/components/block_component.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/resources/items.dart';

class BirchLeafBlock extends BlockComponent {
  BirchLeafBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.birchLeaf);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    if (Random().nextBool()) {
      itemDropped = Items.apple;
    }
  }
}
