import 'package:quadcraft/resources/blocks.dart';
import 'package:quadcraft/resources/gravity_block.dart';

class SandBlock extends GravityBlock {
  SandBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.sand);
}
