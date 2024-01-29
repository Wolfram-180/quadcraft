import 'package:flutter_flame_minecraft/resources/blocks.dart';
import 'package:flutter_flame_minecraft/resources/gravity_block.dart';

class SandBlock extends GravityBlock {
  SandBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.sand);
}
