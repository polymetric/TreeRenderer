import java.util.*;

Random rand;
ArrayList<Block> blocks;

PVector camPos;
float camPitch, camYaw;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  
  rand = new Random(0);
  blocks = new ArrayList<Block>();
  
  // camera init
  camPos = new PVector(10.764066,   -2.600000,   10.244535);
  camYaw = 3.9;
  camPitch =  -0.02;
  
  
  for (int x = -10; x < 10; x++) {
    for (int z = -10; z < 10; z++) {
      if (cheb2D(0, 0, x, z) == 8) {
        blocks.add(new Block(x, 0, z));
      }
    }
  }
}

void draw() {
  background(0);
  lights();
  directionalLight(127, 127, 127, .75, 1, .5);
  noStroke();
  fill(255);
  
  //handleInput();
  //System.out.printf("%12.6f %12.6f %12.6f %12.6f %12.6f\n", camPos.x, camPos.y, camPos.z, Math.toDegrees(camYaw), Math.toDegrees(camPitch));
  
  // camera transform
  PVector target = new PVector(0, 0, 1);
  target = rotateX(target, camPitch);
  target = rotateY(target, camYaw);
  target.add(camPos);
  perspective((float) Math.toRadians(70), (float) width/height, .1, 10000);
  camera(camPos.x, camPos.y, camPos.z, target.x, target.y, target.z, 0, 1, 0); 
  
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
    this(0, 0, 0);
  }
  
  public Block(float x, float y, float z) {
    c = new int[] { 255, 255, 255 };
    pos = new PVector(x, y, z);
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    color(c[0], c[1], c[2]);
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
