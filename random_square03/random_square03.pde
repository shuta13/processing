int numShapes = 60;
int numColors = 4;
// Javaとかでのcolor型配列オブジェクト生成
color palette[] = new color[numColors];

void setup() {
  // 2D OpemGLを使用
  size(800, 800, P2D);
  // MacとかのRetinaでも綺麗に描画
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  noLoop();
  // 指定した座標を中心に長方形を描画するモード
  rectMode(CENTER);
}

void draw() {
  background(0, 0, 95);
  // 原点を中心に移動
  translate(width/2, height/2);
  // パレット1つ目は黒固定
  palette[0] = color(0, 0, 15);
  // 残りのパレットはランダム
  for(int i = 1; i < numColors; i++) {
    palette[i] = color(random(360), random(60, 90), random(60, 90));
  }
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

    // パレットから色を一つランダムに選ぶ
    int paletteIndex = (int)random(numColors);

    // 彩度をランダムにして長方形の描画
    fill(palette[paletteIndex]);
    rect(0, 0, longSide, shortSide);
    // 座標を元に戻す
    popMatrix();
  } 
}

void keyPressed() {
  redraw();
}