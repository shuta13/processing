void setup () {
  size(400, 400);
  background(180);
  noLoop();
}

void draw() {
  background(180);
  float stepx = 10;
  float stepy = 10;
  float lastx = 20;
  float lasty = 50;
  float y = 50;
  for (int x = 20; x <= 480; x += stepx) {
    stepy = random(20) - 10; // -10 ~ 10の範囲
    y += stepy;
    line(x, y, lastx, lasty);
    lastx = x;
    lasty = y;
  }
}

void keyPressed() {
  redraw();
}