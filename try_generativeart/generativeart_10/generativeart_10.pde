boolean saveMode = false;

void setup() {
  size(800, 800, P2D);
  background(255);
  strokeWeight(5);
  noLoop();
}

void draw() {
  float radius = 100;
  int centx = 250;
  int centy = 150;

  stroke(0, 30);
  noFill();
  ellipse(centx, centy, radius*2, radius*2);

  stroke(20, 50, 70);
  strokeWeight(1);

  float x, y;
  float noiseVal = random(10);
  float radVariance, thisRadius, rad;
  beginShape();
  fill(20, 50, 70, 50);
  for (float ang = 0; ang <= 360; ang += 1) {
    noiseVal += 0.1;
    radVariance = 30 * customNoise(noiseVal);

    thisRadius = radius + radVariance;
    rad = radians(ang);
    x = centx + (thisRadius * cos(rad));
    y = centy + (thisRadius * sin(rad));
    
    curveVertex(x, y);
  }
  endShape();
}

float customNoise(float value) {
  int count = int((value % 12));
  float retValue = pow(sin(value), count);
  return retValue;
}

void keyPressed() {
  redraw();
  if (key == 's') {
    saveMode = true;
  }
}