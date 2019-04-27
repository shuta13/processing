boolean saveMode = false;

int num = 10;
float angle = 0;
Circle[] circleArr = {};

void setup() {
  size(800, 800, P2D);
  background(255);
  strokeWeight(1);
  fill(150, 50);
  drawCircles();
}

void draw() {
  // background(255);
  for (int i = 0; i < circleArr.length; i++) {
    Circle thisCirc = circleArr[i];
    thisCirc.updateMe();
  }

  if (saveMode) {
    saveFrame("frames/frame-####.png");
    delay(100);
    exit();
  }
}

void keyPressed() {
  if (key == 's') saveMode = true;
}

void mouseReleased() {
  drawCircles();
}

void drawCircles() {
  for (int i = 0; i < num; i++) {
    Circle thisCirc = new Circle();
    thisCirc.drawMe();
    circleArr = (Circle[])append(circleArr, thisCirc);
  }
}

class Circle {
  float x, y;
  float radius;
  color linecol, fillcol;
  float alph;
  float xmove, ymove;

  Circle() {
    x = random(width);
    y = random(height);
    radius = random(100) + 10;
    linecol = color(random(255), random(255), random(255));
    fillcol = color(random(255), random(255), random(255));
    alph = random(255);
    xmove = random(10) - 5;
    ymove = random(10) - 5;
  }

  void drawMe() {
    noStroke();
    // fill(fillcol, alph);
    rect(x, y, radius*2, radius*2);
    noFill();
    rect(x, y, 10, 10);
    noStroke();
    fill(240, 20);
    rect(x, y, 10, 10);
    filter(BLUR, 0.2);
  }

  void updateMe() {
    float rad = radians(angle);
    x += xmove + (sin(rad)*2); 
    y += ymove;
    if (x > (width+radius)) { x = 0 - radius; }
    if (x < (0-radius)) { x = width+radius; }
    if (y > (height+radius)) { y = 0 - radius; }
    if (y < (0-radius)) { y = height+radius; }

    boolean touching = false;
    for (int i = 0; i < circleArr.length; i++) {
      Circle otherCirc = circleArr[i];
      if (otherCirc != this) {
        float dis = dist(x, y, otherCirc.x, otherCirc.y);
        float overlap = dis - radius - otherCirc.radius;
        if (overlap < 0) {
          float midx, midy;
          midx = (x + otherCirc.x) / 2;
          midy = (y + otherCirc.y) / 2;
          stroke(0, 2);
          noFill();
          overlap *= -1;
          fill(20, fillcol%255%10, fillcol%255, 0);
          rect(midx, midy, overlap, overlap);
          fill(20, fillcol%255%10, fillcol%255, 0);
          noStroke();
          rect(midx, midy, overlap, overlap);
        }
      }
    }

    if (touching) {
      if (alph < 255) alph--;
    } else {
      if (alph < 255) alph += 2;
    }
    drawMe();

    angle++;
  }
}