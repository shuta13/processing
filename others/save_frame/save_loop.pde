boolean keyMode = false;

void setup() {
  // いつもの
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  background(255);
}

void draw() {
  // なんかしらの処理
  if (keyMode) {
    saveFrame("frames/frame-####.png");
    delay(100);
    exit();
  }
}

void keyPressed() {
  redraw();
  if (key == 's') {
    keyMode = true;
  }
}
