long treeSeed = 0;

void genTrees() {
  RandomOverride rand = new RandomOverride();
  //rand.setSeed(treeSeed);
  rand.setSeedDirect(treeSeed);
  
  //for (int i = 0; i < 6; i++) {
  //  int baseX = rand.nextInt(16);
  //  int baseZ = rand.nextInt(16);
  //  int baseY = 0;
    
  //  genTree(rand, baseX, baseY, baseZ);
  //}
  //genTree(rand, 0, 0, 0);
  genTaigaTree1(rand, 0, 0, 0);
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
          blocks.add(new Block(x, y, z, new Color(0, 127, 0)));
        }
      }
    }
  }
  
  for (int i = 0; i < trunkHeight; i++) {
    blocks.add(new Block(baseX, baseY + i, baseZ, new Color(127, 64, 0)));
  }
}

Color leafIncRadius = new Color(227, 185, 45);
Color leafDecRadius = new Color(56, 126, 165);

//int totalHeight = 11;
//int trunkHeight = 7;
//int radiusLimit = 0;

void genTaigaTree1(RandomOverride rand, int baseX, int baseY, int baseZ) {
  Color leafColor = new Color(0, 50, 20);
  
  int totalHeight;
  int trunkHeight;
  int radiusLimit;
  
  totalHeight = rand.nextInt(5) + 7;
  trunkHeight = totalHeight - rand.nextInt(2) - 3;
  int leafHeight = totalHeight - trunkHeight;
  radiusLimit = 1 + rand.nextInt(leafHeight + 1);
  
  //println();
  //println("totalHeight: "+totalHeight);
  //println("trunkHeight: "+trunkHeight);
  //println("radiusLimit: "+radiusLimit);
  

  // leaves
  int radius = 0;
  for (int y = baseY + totalHeight; y >= baseY + trunkHeight; y--) {
    for (int x = baseX - radius; x <= baseX + radius; x++) {
      int relX = x - baseX;
      for (int z = baseZ - radius; z <= baseZ + radius; z++) {
        int relZ = z - baseZ;
        if ((Math.abs(relX) != radius || Math.abs(relZ) != radius || radius <= 0) && relZ < 1) {
          blocks.add(new Block(x, y, z, leafColor));
        }
      }
    }

    if (radius >= 1 && y == baseY + trunkHeight + 1) {
      radius--;
      continue;
    }
    if (radius < radiusLimit) {
      radius++;
    }
  }

  // trunk
  for (int y = 0; y < totalHeight - 1; y++) {
    blocks.add(new Block(baseX, y, baseZ, new Color(50, 20, 10)));
  }
}

void genTaigaTree2(RandomOverride rand, int baseX, int baseY, int baseZ) {
  Color leafColor = new Color(0, 50, 20);
  boolean canSpawn = true;
  
  int trunkHeight;
  int i1;
  int leafHeight;
  int maxRadiusLimit;
  trunkHeight = rand.nextInt(4) + 6;
  i1 = 1 + rand.nextInt(2);
  leafHeight = trunkHeight - i1;
  maxRadiusLimit = 2 + rand.nextInt(2);
  for (int y = baseY; y <= baseY + 1 + trunkHeight && canSpawn; y++) {
    int radius = 1;
    if (y - baseY < i1) {
        radius = 0;
    } else {
        radius = maxRadiusLimit;
    }
  }

  
  // leaves
  int radius = rand.nextInt(2);
  int radiusLimit = 1;
  boolean flag1 = false;
  for (int relY = 0; relY <= leafHeight; relY++) {
    int y = (baseY + trunkHeight) - relY;
    for (int x = baseX - radius; x <= baseX + radius; x++) {
      int relX = x - baseX;
      for (int z = baseZ - radius; z <= baseZ + radius; z++) {
        int relZ = z - baseZ;
        if ((Math.abs(relX) != radius || Math.abs(relZ) != radius || radius <= 0) && relZ < 1) {
          blocks.add(new Block(x, y, z, leafColor));
        }
      }
    }

    if (radius >= radiusLimit) {
      radius = ((flag1) ? 1 : 0);
      flag1 = true;
      if (++radiusLimit > maxRadiusLimit) {
          radiusLimit = maxRadiusLimit;
      }
    } else {
      radius++;
    }
  }
  
  // trunk
  int topLeaves = rand.nextInt(3);
  for (int y = 0; y < trunkHeight - topLeaves; y++) {
    blocks.add(new Block(baseX, y, baseZ, new Color(50, 20, 10)));
  }
}
