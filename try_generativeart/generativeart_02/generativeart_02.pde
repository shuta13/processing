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
  float noisey = random(10);
  float y = 50;
  for (int x = 20; x <= 480; x += stepx) {
    y = 10 + noise(noisey) * 80;
    if (lastx >= -999) {
      line(x, y, lastx, lasty);
    }
    lastx = x;
    lasty = y;
    noisey += 0.1;
  }
}

void keyPressed() {
  redraw();
}