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

  BlockData({
    required this.isCollidable,
    required this.baseMiningSpeed,
  });
}
