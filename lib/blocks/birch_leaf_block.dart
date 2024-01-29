import 'dart:math';

import 'package:quadcraft/components/block_component.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/items.dart';

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
