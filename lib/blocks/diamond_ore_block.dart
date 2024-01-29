import 'package:quadcraft/components/block_component.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/items.dart';

class DiamondOreBlock extends BlockComponent {
  DiamondOreBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.diamondOre);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    itemDropped = Items.diamond;
  }
}
