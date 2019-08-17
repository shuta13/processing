int numShapes = 60;
int numColors = 4;
// Javaとかでのcolor型配列オブジェクト生成
color palette[] = new color[numColors];

// デバイスピクセル比
int dpr = 1;
boolean doPostProcess = true;
// boolean doSave = true;

void setup() {
  // 2D OpemGLを使用
  size(800, 800, P2D);
  // MacとかのRetinaでも綺麗に描画
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  noLoop();
  // 指定した座標を中心に長方形を描画するモード
  rectMode(CENTER);
  imageMode(CENTER);
  // デバイスピクセル比を保存しておく
  dpr = displayDensity();
}

void draw() {
  background(0, 0, 95);
  // 原点を中心に移動
  translate(width/2, height/2);
  // パレット1つ目は黒固定
  palette[0] = color(0, 0, 15);
  // 残りのパレットはランダム
  for (int i = 1; i < numColors; i++) {
    palette[i] = color(random(360), random(60, 90), random(60, 90));
  }
  noStroke();
  for (int i = 0; i < numShapes; i++) {
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
    if (isVertical) rotate(HALF_PI);
    
    int shadowWidth = longSide + 20;
    int shadowHeight = shortSide + 20;

    PGraphics shadow = createGraphics(shadowWidth, shadowHeight);
    // 描画開始
    shadow.beginDraw();
    shadow.rectMode(CENTER);
    shadow.noStroke();
    shadow.fill(0, 100);
    shadow.rect(shadowWidth/2, shadowHeight/2, longSide, shortSide);
    shadow.filter(BLUR, 4);
    shadow.endDraw();
    // 描画終了
    
    // 右下に影を出す
    if (isVertical) image(shadow, 4, -4); // 縦の時の影
    else image(shadow, 4, 4); // 横の時の影
    // パレットから色を一つランダムに選ぶ
    int paletteIndex = (int)random(numColors);

    // パレットの色で長方形の描画
    fill(palette[paletteIndex]);
    rect(0, 0, longSide, shortSide);
    // 座標を元に戻す
    popMatrix();
  } 

  if (doPostProcess) {
    postprocess();
  }
  
  // 自動で保存
  // if (doSave) {
  //   saveFrame("frames/frame-####.png");
  // }
}

// 画面にざらつきを与える
void postprocess() {
  for (int y = 0; y < height * dpr; y++) {
    for (int x = 0; x < width * dpr; x++) {
      // -5〜5の間の明度の差を作る
      float bri = random(-5, 5);
      // ピクセル(x, y)の色を取得
      color c = get(x, y);
      // 新しい色を設定
      c = color(hue(c), saturation(c), brightness(c)+bri);
      // 新しい色で今のピクセルを更新
      set(x, y, c);
    }
  }
}

void keyPressed() {
  redraw();
  // sキー入力で保存
  if (key == 's') {
    saveFrame("frames/frame-####.png");
  }
}
