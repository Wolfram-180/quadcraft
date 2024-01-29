import 'package:flutter_flame_minecraft/components/block_component.dart';
import 'package:flutter_flame_minecraft/resources/blocks.dart';

class StoneBlock extends BlockComponent {
  StoneBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.stone);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    itemDropped = Blocks.cobblestone;
  }
}
