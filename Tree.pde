long treeSeed = 0;

void genTrees() {
  RandomOverride rand = new RandomOverride(treeSeed);
  
  //for (int i = 0; i < 6; i++) {
  //  int baseX = rand.nextInt(16);
  //  int baseZ = rand.nextInt(16);
  //  int baseY = 0;
    
  //  genTree(rand, baseX, baseY, baseZ);
  //}
  genTree(rand, 0, 0, 0);
}

void genTree(RandomOverride rand, int baseX, int baseY, int baseZ) {
  int trunkHeight = rand.nextInt(3) + 4;
  
  for (int y = baseY + trunkHeight - 3; y <= baseY + trunkHeight; y++) {
    int distFromTop = y - (baseY + trunkHeight);
    int radius = 1 - distFromTop / 2;
    for (int x = baseX - radius; x <= baseX + radius; x++) {
      int relX = x - baseX;
      for (int z = baseZ - radius; z <= baseZ + radius; z++) {
      int relZ = z - baseZ;
        if (abs(relX) != radius || abs(relZ) != radius || rand.nextInt(2) != 0 && distFromTop != 0) {
          blocks.add(new Block(x, y, z, 0, 127, 0));
        }
      }
    }
  }
  
  for (int i = 0; i < trunkHeight; i++) {
    blocks.add(new Block(baseX, baseY + i, baseZ, 127, 64, 0));
  }
}
