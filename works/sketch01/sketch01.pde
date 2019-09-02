boolean saveMode = false;

void keyPressed() {
  redraw();
  if (key == 's') {
    saveMode = true;
  }
}

void setup() {
  // fullScreen(P2D);
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  noStroke();
  noLoop();
}

void draw() {

  testModule();

  if (saveMode) {
    saveFrame("frames/frame-####.png");
    delay(100);
    exit();
  }
}

void testModule() {
  background(255);

  float radius = 100;
  int centx = width / 2;
  int centy = height / 2;

  stroke(0, 30);
  strokeWeight(10);
  noFill();
  // ellipse(centx, centy, radius*2, radius*2);

  stroke(20, 50, 70);
  radius = 10;
  float x, y;
  float lastx = -999;
  float lasty = -999;
  // float radiusNoise = random(10);
  for (float ang = 0; ang <= 1440; ang += 5) {
    // radiusNoise += 0.05;
    radius += 0.5;
    // float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
    float rad = radians(ang);
    // x = centx + (thisRadius * cos(rad));
    // y = centy + (thisRadius * sin(rad));
    x = centx + (radius * cos(rad));
    y = centy + (radius * sin(rad));
    if (lastx > -999) {
      line(x, y, lastx, lasty);
    }
    lastx = x;
    lasty = y;
  }
}
