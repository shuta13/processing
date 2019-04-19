boolean saveMode = false;
float xstart, xnoise, ystart, ynoise;
float xstartNoise, ystartNoise;

void setup() {
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  // noLoop();
  frameRate(24);
  background(255);

  xstartNoise = random(20);
  ystartNoise = random(20);
  xstart = random(10);
  ystart = random(10);
}

void draw() {
  background(255);
  xstart += 0.01;
  ystart += 0.01;
  
  xstartNoise += 0.01;
  ystartNoise += 0.01;
  xnoise += (noise(xstartNoise) * 0.5) - 0.25;
  ynoise += (noise(ystartNoise) * 0.5) - 0.25;
  
  xnoise = xstart;
  ynoise = ystart;

  for (int y = 0; y <= height; y += 5) {
    ynoise += 0.1;
    xnoise = xstart;
    for (int x = 0; x <= width; x += 5) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }

  if (saveMode) {
    saveFrame("frames/frame-####.png");
    delay(100);
    exit();
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(360));
  stroke(0, 150);
  fill((xnoise*ynoise)%255, 80);
  // rect(0, 0, 20, 20);
  line(0, 0, 20, 0);
  popMatrix();
}

void keyPressed() {
  // redraw();
  if (key == 's') {
    saveMode = true;
  }
}