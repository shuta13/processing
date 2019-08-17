boolean saveMode = false;

void setup() {
  fullScreen(P2D);
  pixelDensity(displayDensity());
  noStroke();
  noLoop();
}

void draw() {

  background(0);

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