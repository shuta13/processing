boolean saveMode = false;

int numChildlen = 3;
int maxLevels = 8;

Branch trunk;

void setup() {
  fullScreen(P2D);
  background(255);
  noFill();
  newTree();
  noLoop();
  frameRate(2);
}

void newTree() {
  trunk = new Branch(1, 0, width/2, height/2);
  trunk.drawMe();
}

void draw() {
  background(0);
  trunk.updateMe(width/2, height/2);
  trunk.drawMe();
  if (saveMode) {
    saveFrame("frames/frame-####.png");
    delay(100);
    exit();
  }
}

void keyPressed() {
  redraw();
  if (key == 's') {
    saveMode = true;
  }
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
    float thisRadius = 250;
    float radian = radians(rot);

    x = ex + (thisRadius * cos(radian)*noise(random(10)));
    y = why + (thisRadius * sin(radian)*noise(random(10)));

    rot += rotChange;
    if (rot > 360) { rot = 0; }
    else if (rot < 0) { rot = 360; }

    len -= lenChange;
    if (len < 0) { lenChange *= -1; }
    else if (len > 200) { lenChange *= -1; }

    endx = x + (len * cos(radian)*noise(random(10)));
    endy = y + (len * sin(radian)*noise(random(10)));

    for (int i = 0; i < childlen.length; i++) {
      childlen[i].updateMe(endx, endy);
    }
  }

  void drawMe() {
    if (level > 1) {
      strokeWeight(strokeW);
      if ((x > width/2) || (y < height/2)) alph = (10+alph)%100; 
      stroke(random(10)*alph%255, random(10)*alph%255, random(10)*alph%255, alph);
      fill(255-255, alph);
      // fill(255, alph);
      line(x, y, endx, endy);
      fill(255-(random(10)*alph%255), 255-40, 255-(random(10)*alph%255), alph);
      // fill(random(10)*alph%255, 40, random(10)*alph%255, alph);
      rect(endx, endy, strokeW*random(10), strokeW*random(10));
      if (x > width/2*random(10)) { 
        // noStroke();
        fill(255-(random(10)*alph%255), 255-40, 255-(random(10)*alph%255), alph);
        // fill(random(10)*alph%255, 40, random(10)*alph%255, 80);
        // ここの縦横入れ替えると無限にグリッヂぽくして遊べる
        rect(x, y, endx%20, endy%1000);
      } else { 
        ellipse(x, y, endx%5, endy%5); 
      }
    }
    for (int i = 0; i < childlen.length; i++) {
      childlen[i].drawMe();
    }
  }
}