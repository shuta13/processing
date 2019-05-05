int numChildlen = 3;
int maxLevels = 10;

Branch trunk;

void setup() {
  size(800, 800, P2D);
  background(255);
  noFill();
  newTree();
}

void newTree() {
  trunk = new Branch(1, 0, width/2, height/2);
  trunk.drawMe();
}

void draw() {
  background(255);
  trunk.updateMe(width/2, height/2);
  trunk.drawMe();
}

class Branch {
  float level, index;
  float x, y;
  float endx, endy;

  float strokeW, alph;
  float len, lenChange;
  float rot, rotChange;

  Branch[] childlen = new Branch[0];

  Branch(float lev, float ind, float ex, float why) {
    level = lev;
    index = ind;

    // strokeW = (1/level) * 100;
    strokeW = (1/level) * 10;
    alph = 255 / level;
    len = (1/level) * random(200);
    rot = random(360);
    lenChange = random(10) - 5;
    rotChange = random(10) - 5;

    updateMe(ex, why);

    if (level < maxLevels) {
      childlen = new Branch[numChildlen];
      for (int x = 0; x < numChildlen; x++) {
        childlen[x] = new Branch(level+1, x, endx, endy);
      }
    }
  }

  void updateMe(float ex, float why) {
    x = ex;
    y = why;

    rot += rotChange;
    if (rot > 360) { rot = 0; }
    else if (rot < 0) { rot = 360; }

    len -= lenChange;
    if (len < 0) { lenChange *= -1; }
    else if (len > 200) { lenChange *= -1; }

    float radian = radians(rot);
    endx = x + (len * cos(radian));
    endy = y + (len * sin(radian));

    for (int i = 0; i < childlen.length; i++) {
      childlen[i].updateMe(endx, endy);
    }
  }

  void drawMe() {
    if (level > 1) {
      strokeWeight(strokeW);
      stroke(0, alph);
      fill(255, alph);
      line(x, y, endx, endy);
      ellipse(x, y, 5, 5);
    }
    for (int i = 0; i < childlen.length; i++) {
      childlen[i].drawMe();
    }
  }
}