void setup() {
  size(400, 300);
  background(230, 230, 230);
}

float x = 10;
float y = 10;

float dx = 1;
float dy = 2;

void draw() {
  if (x > width) {
    dx = -1;
  } else if (x < 0) {
    dx = 1;
  }
  if (y > height) {
    dy = -2;
  } else if (y < 0) {
    dy = 2;
  }

  x = x + dx;
  y = y + dy;

  stroke(0, 0, 0);
  fill(0, 0, 0);

  background(230, 230, 230);
  ellipse(x, y, 8, 8);
}
