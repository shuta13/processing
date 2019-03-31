void setup() {
  size(800, 300, P2D);
  noLoop();
  rectMode(CENTER);
}

void draw() {
  background(220);
  translate(width/2, height/2);
  
  int longSide = 200;
  int shortSide = 60;

  noStroke();

  // 透明感ある黒で影を描画
  fill(0, 100);
  rect(4, 4, longSide, shortSide);
  filter(BLUR, 4);
  // 白で長方形を描画
  fill(255);
  rect(0, 0, longSide, shortSide);
}