int numShapes = 60;

void setup() {
  // 2D OpenGLを利用
  size(800, 800, P2D);
  // MacとかのRetinaでも綺麗に出る
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  noLoop();
  rectMode(CENTER);
}

void draw() {
  background(0, 0, 95);
  translate(width/2, height/2);
  noStroke();
  for(int i = 0; i < numShapes; i++) {
    // 長方形の中心のx座標
    float centerX = random(-width/2, width/2); 
    // 長方形の中心のy座標
    float centerY = random(-height/2, height/2);
    // 横向きか縦向きか
    boolean isVertical = random(1) < 0.5;
    // 長方形の長い方の長さ
    int longSide = (int)random(200, 600);
    // 長方形の短い方の長さ
    int shortSide = (int)random(10, 20);
    // 原点を長方形の中心に移動
    pushMatrix();
    translate(centerX, centerY);
    // 90度回転して横向きにする
    if(isVertical) rotate(HALF_PI);
    // 彩度をランダムにして長方形の描画
    fill(random(360), 80, 80);
    rect(0, 0, longSide, shortSide);
    // 座標を元に戻す
    popMatrix();
  } 
}

void keyPressed() {
  redraw();
}
