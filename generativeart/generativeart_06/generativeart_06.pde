boolean keyMode = false;

float angnoise, radiusnoise;
float xnoise, ynoise;
float angle = -PI/2;
float radius;
float strokeCol = 254;
int strokeChange = -1;

void setup() {
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  background(255);
  frameRate(30);
  smooth();
  noFill();

  angnoise = random(10);
  radiusnoise = random(10);
  xnoise = random(10);
  ynoise = random(10);
}

void draw() {
  radiusnoise += 0.005;
  radius = (noise(radiusnoise) * 550) + 1;

  angnoise += 0.005;
  angle += (noise(angnoise) * 6) - 3;

  if (angle > 30) angle -= 360;
  if (angle < 0) angle += 360;

  xnoise += 0.01;
  ynoise += 0.01;
  float centerX = width / 2 + (noise(xnoise) * 100) - 50;
  float centerY = height / 2 + (noise(ynoise) * 100) - 50;

  float rad = radians(angle);
  float x1 = centerX + (radius * cos(rad));
  float y1 = centerY + (radius * sin(rad));
  float opprad = rad + PI;
  float x2 = centerX + (radius * cos(opprad));
  float y2 = centerY + (radius * sin(opprad));

  strokeCol += strokeChange;

  if (strokeCol  > 254) strokeChange = -1;
  if (strokeCol < 0) strokeCol = 1;
  stroke(strokeCol, 60);
  strokeWeight(1);
  line(x1, y1, x2, y2);

  int counter = 0;
  while (keyMode) {
    saveFrame("frames/frame-####.png");
    counter++;
    if (counter == 2) break;
  }
}

void keyPressed() {
  if (key == 's') {
    keyMode = true;
  }
}