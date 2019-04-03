int numColors = 4;
// Javaとかでのcolor型配列オブジェクト生成
color palette[] = new color[numColors];

// デバイスピクセル比
int dpr = 1;
boolean doPostProcess = true;
boolean doSave = false;

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
  // パレット1つ目は黒固定
  palette[0] = color(0, 0, 15);
  // 残りのパレットはランダム
  for (int i = 1; i < numColors; i++) {
    palette[i] = color(random(360), random(60, 90), random(60, 90));
  }

  // 長方形と長方形の隙間
  float space = 6.0;
  // 長方形の幅
  float rectWidth = (width-space*10.0)/10.0;
  noStroke();
  
  // 縦横に長方形をspaceの間隔をあけて敷き詰める
  for (float x = space; x < width; x += rectWidth + space) {
    for (float y = 0; y < height; ) {
      // 長方形の高さ
      float rectHeight = random(20, 50);
      pushMatrix();

      translate(x+rectWidth/2, y+rectHeight/2);

      int shadowWidth = (int)rectWidth + 20;
      int shadowHeight = (int)rectHeight + 20;

      PGraphics shadow = createGraphics(shadowWidth, shadowHeight);
      // 描画開始
      shadow.beginDraw();
      shadow.background(0, 0, 0, 0);
      shadow.rectMode(CENTER);
      shadow.noStroke();
      shadow.fill(0, 100);
      shadow.rect(shadowWidth/2, shadowHeight/2, rectWidth, rectHeight);
      shadow.filter(BLUR, 4);
      shadow.endDraw();
      image(shadow, 4, 4);
      // パレットから色を一つランダムに選ぶ
      int paletteIndex = (int)random(numColors);

      // パレットの色で長方形の描画
      fill(palette[paletteIndex]);
      rect(0, 0, rectWidth, rectHeight);
      
      y += rectHeight + space;
      // 座標を元に戻す
      popMatrix();
    }
  }
  
  if (doPostProcess) {
    postprocess();
  }
  
  // framesに現在のフレームをpngで保存
  if (doSave) {
    saveFrame("frames/frame-####.png");
  }
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
  // sキー入力で保存
  if (key == 's') {
    saveFrame("frames/frame-####.png");
  } else {
    redraw();
  }
}

