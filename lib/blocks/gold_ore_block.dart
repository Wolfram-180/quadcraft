import 'package:quadcraft/components/block_component.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/items.dart';

class GoldOreBlock extends BlockComponent {
  GoldOreBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.goldOre);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    itemDropped = Items.goldIngot;
  }
}
