import java.util.*;

int time;
Random rand;
ArrayList<Block> blocks;

PVector camPos;
float camPitch, camYaw;

void setup() {
  size(1600, 864, P3D);
  smooth(8);
  frameRate(60);
  
  time = 0;
  rand = new Random(0);
  blocks = new ArrayList<Block>();
  
  // camera init
  camPos = new PVector(-12.211766,   -0.600000,   17.997593);
  camYaw = 2.534997; 
  camPitch = 0.262463;

  trunkHeight = 9; // 6..9
  baseHeight = 2; // 1..2
  leafHeight = trunkHeight - baseHeight; // 4..7
  maxRadiusLimit = 3; // 2..3
  topLeaves = 0; // 0..2
  initialRadius = 1; // 0..1
}

int trunkHeight;
int baseHeight;
int leafHeight;
int maxRadiusLimit;
int topLeaves;
int initialRadius;


void draw() {
  background(0);
  
  lights();
  directionalLight(127, 127, 127, .75, 1, .5);
  
  if (time % 5 == 0) {
    blocks.clear();
    genTrees();
  
    //treeSeed += 1;
    treeSeed = rand.nextLong();
    
    leafHeight = trunkHeight - baseHeight; // 4..7
  }
  
  handleInput();
  //System.out.printf("%12.6f %12.6f %12.6f %12.6f %12.6f\n", camPos.x, camPos.y, camPos.z, camYaw, camPitch);
  
  // camera transform
  PVector target = new PVector(0, 0, 1);
  target = rotateX(target, camPitch);
  target = rotateY(target, camYaw);
  target.add(camPos);
  perspective((float) Math.toRadians(40), (float) width/height, .1, 10000);
  camera(camPos.x, camPos.y, camPos.z, target.x, target.y, target.z, 0, 1, 0);
  rotateZ(PI);
  
  //translate(random(100) - 50, random(100) - 50, random(100) - 50);
  //translate(0, 0, 10);
  
  for (Block block : blocks) {
    block.draw();
  }
  
  time++;
}

class Block {
  Color clr;
  PVector pos;
  
  public Block() {
    this(0, 0, 0);
  }
  
  public Block(float x, float y, float z) {
    this(x, y, z, new Color(255, 255, 255));
  }
  
  public Block(float x, float y, float z, Color clr) {
    pos = new PVector(x, y, z);
    this.clr = clr;
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    scale(.95);
    noStroke();
    fill(clr.r, clr.g, clr.b);
    box(1);
    popMatrix();
  }
}

class Color {
  int r, g, b;
  public Color(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
}

public static int cheb2D(int x1, int y1, int x2, int y2) {
  return max(abs(x1 - x2), abs(y1 - y2));
}

PVector rotateX(PVector v, float a) {
  PVector o = new PVector();
  float s = sin(a);
  float c = cos(a);
  o.x = v.x;
  o.y = v.y * c + v.z * -s;
  o.z = v.y * s + v.z *  c;
  return o;
}

PVector rotateY(PVector v, float a) {
  PVector o = new PVector();
  float s = sin(a);
  float c = cos(a);
  o.x = v.x * c + v.z * s;
  o.y = v.y;
  o.z = v.x * -s + v.z * c;
  return o;
}
