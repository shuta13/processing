int num = 10;
Circle[] circleArr = {};

void setup() {
  size(500, 300, P2D);
  background(255);
  strokeWeight(1);
  fill(150, 50);
  drawCircles();
}

void draw() {
  background(255);
  for (int i = 0; i < circleArr.length; i++) {
    Circle thisCirc = circleArr[i];
    thisCirc.updateMe();
  }
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
    fill(fillcol, alph);
    ellipse(x, y, radius*2, radius*2);
    stroke(linecol, 150);
    noFill();
    ellipse(x, y, 10, 10);
  }

  void updateMe() {
    x += xmove;
    y += ymove;
    if (x > (width+radius)) { x = 0 - radius; }
    if (x < (0-radius)) { x = width+radius; }
    if (y > (height+radius)) { y = 0 - radius; }
    if (y < (0-radius)) { y = height+radius; }

    drawMe();
  }
}