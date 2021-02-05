import java.util.*;

Random rand;
ArrayList<Block> blocks;

PVector camPos;
float camPitch, camYaw;

void setup() {
  size(1600, 864, P3D);
  smooth(8);
  frameRate(60);
  
  rand = new Random(0);
  blocks = new ArrayList<Block>();
  
  // camera init
  camPos = new PVector( -6.775806,   -0.600000,    9.964614);
  camYaw = 2.579375   ; 
  camPitch = 0.146722;
  
  genTrees();
}

void draw() {
  background(0);
  lights();
  directionalLight(127, 127, 127, .75, 1, .5);
  
  //blocks.clear();
  //genTrees();
  //treeSeed += 1;
  
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
}

class Block {
  int[] c;
  PVector pos;
  
  public Block() {
    this(0, 0, 0, 255, 255, 255);
  }
  
  public Block(float x, float y, float z, int r, int g, int b) {
    pos = new PVector(x, y, z);
    c = new int[] { r, g, b };
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    noStroke();
    fill(c[0], c[1], c[2]);
    box(1);
    popMatrix();
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
