import 'package:quadcraft/components/block_component.dart';
import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/items.dart';

class IronOreBlock extends BlockComponent {
  IronOreBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.ironOre);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    itemDropped = Items.ironIngot;
  }
}
