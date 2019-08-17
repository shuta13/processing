boolean saveMode = false;
float xstart, xnoise, ynoise;

void setup() {
  size(800, 800, P2D);
  smooth();
  noLoop();
}

void draw() {
  background(255);
  xstart = random(10);
  xnoise = xstart;
  ynoise = random(10);
  for (int y = 0; y <= height; y += 5) {
    ynoise += 0.1;
    xnoise += xstart;
    for (int x = 0; x <= width; x += 5) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }
  if (saveMode) {
    saveFrame("frames01/frame-####.png");
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  float len = 10 * noiseFactor;
  rect(x, y, len, len);
}

void keyPressed() {
  redraw();
  if (key == 's') {
    saveMode = true;
  }
}