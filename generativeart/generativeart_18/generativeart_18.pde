int radius = 100;
float noiseCol = random(10) * 0.01;

void setup() {
  size(500, 300, P3D);
  background(0);
}

void draw() {
  stroke(noiseCol*1000%255, noiseCol*1000%255, noiseCol%10);
  noiseCol += 0.1;
  background(0);
  translate(width/2, height/2, height/2);
  rotateY(frameCount * 0.03);
  rotateX(frameCount * 0.04);

  float n = noise(noiseCol);
  float s = 0;
  float t = 0;
  float lastx = 0;
  float lasty = 0;
  float lastz = 0;

  while (t < 180) {
    s += 18;
    t += 1;
    float radianS = radians(s);
    float radianT = radians(t);

    float thisx = 0 + (radius*n * cos(radianS)*s/t * sin(radianT));
    float thisy = 0 + (radius*n * sin(radianS)*s/t * sin(radianT));
    float thisz = 0 + (radius*n * cos(radianT));

    if (lastx != 0) {
      line(thisx, thisy, thisz, lastx, lasty, lastz);
    }
    lastx = thisx;
    lasty = thisy;
    lastz = thisz;
  }
}
