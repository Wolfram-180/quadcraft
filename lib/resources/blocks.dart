enum Blocks {
  grass,
  dirt,
  stone,
  birchLog,
  birchLeaf,
  cactus,
  deadBush,
  sand,
  coalOre,
  ironOre,
  diamondOre,
  goldOre,
  grassPlant,
  redFlower,
  purpleFlower,
  drippingWhiteFlower,
  yellowFlower,
  whiteFlower,
  birchPlank,
  craftingTable,
  cobblestone,
  bedrock,
}

class BlockData {
  final bool isCollidable;
  final double baseMiningSpeed;
  final bool isBreakable;

  BlockData({
    required this.isCollidable,
    required this.baseMiningSpeed,
    this.isBreakable = true,
  });

  factory BlockData.getBlockDataFor(Blocks block) {
    switch (block) {
      case Blocks.dirt:
        return BlockData.soil;

      case Blocks.grass:
        return BlockData.soil;

      case Blocks.birchLeaf:
        return BlockData.leaf;

      case Blocks.birchLog:
        return BlockData.wood;

      case Blocks.cactus:
        return BlockData.plant;

      case Blocks.coalOre:
        return BlockData.stone;

      case Blocks.deadBush:
        return BlockData.plant;

      case Blocks.ironOre:
        return BlockData.stone;

      case Blocks.sand:
        return BlockData.soil;

      case Blocks.stone:
        return BlockData.stone;

      case Blocks.grassPlant:
        return BlockData.plant;

      case Blocks.redFlower:
        return BlockData.plant;

      case Blocks.purpleFlower:
        return BlockData.plant;

      case Blocks.drippingWhiteFlower:
        return BlockData.plant;

      case Blocks.yellowFlower:
        return BlockData.plant;

      case Blocks.whiteFlower:
        return BlockData.plant;

      case Blocks.diamondOre:
        return BlockData.stone;

      case Blocks.goldOre:
        return BlockData.stone;

      case Blocks.birchPlank:
        return BlockData.woodPlank;

      case Blocks.craftingTable:
        return BlockData.woodPlank;

      case Blocks.cobblestone:
        return BlockData.stone;

      case Blocks.bedrock:
        return BlockData.unbreakable;
    }
  }

  // static BlockComponent getParentForBlock(
  //     Blocks block, Vector2 blockIndex, int chunkIndex) {
  //   switch (block) {
  //     case Blocks.craftingTable:
  //       return CraftingTableBlock(
  //           chunkIndex: chunkIndex, blockIndex: blockIndex);

  //     case Blocks.birchLeaf:
  //       return BirchLeafBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

  //     case Blocks.stone:
  //       return StoneBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

  //     case Blocks.coalOre:
  //       return CoalOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

  //     case Blocks.ironOre:
  //       return IronOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

  //     case Blocks.diamondOre:
  //       return DiamondOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

  //     case Blocks.goldOre:
  //       return GoldOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

  //     case Blocks.sand:
  //       return SandBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

  //     default:
  //       return BlockComponent(
  //           block: block, blockIndex: blockIndex, chunkIndex: chunkIndex);
  //   }
  // }

  static BlockData plant = BlockData(
    isCollidable: false,
    baseMiningSpeed: 0.0000001,
  );
  // suitableTool: Tools.none);

  static BlockData soil = BlockData(
    isCollidable: true,
    baseMiningSpeed: 0.75,
  ); //suitableTool: Tools.shovel);

  static BlockData wood = BlockData(
    isCollidable: false,
    baseMiningSpeed: 3,
  ); // suitableTool: Tools.axe);

  static BlockData leaf = BlockData(
    isCollidable: false,
    baseMiningSpeed: 0.35,
  ); //suitableTool: Tools.axe);

  static BlockData stone = BlockData(
    isCollidable: true,
    baseMiningSpeed: 3.5,
  ); //suitableTool: Tools.pickaxe);

  static BlockData woodPlank = BlockData(
    isCollidable: true,
    baseMiningSpeed: 2.5,
  ); //suitableTool: Tools.axe);

  static BlockData unbreakable = BlockData(
    isBreakable: false,
    baseMiningSpeed: 1,
    isCollidable: true,
  );
  // suitableTool: Tools.none);
}
