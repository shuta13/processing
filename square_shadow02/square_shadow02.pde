// 影を別のスクリーンで描画している
void setup() {
  size(800, 300, P2D);
  noLoop();
  rectMode(CENTER);
  // 指定した座標の中心に画像を描画するモード
  imageMode(CENTER);
}

void draw() {
  background(220);
  translate(width/2, height/2);
  
  int longSide = 200;
  int shortSide = 60;
  // 影の幅
  int shadowWidth = longSide + 40;
  // 影の高さ
  int shadowHeight = shortSide + 40;
  // 影のオフスクリーン(別のスクリーン)作成
  PGraphics shadow = createGraphics(shadowWidth, shadowHeight);
  shadow.beginDraw();
  shadow.rectMode(CENTER);
  shadow.noStroke();
  shadow.fill(0, 100);
  shadow.rect(shadowWidth/2, shadowHeight/2, longSide, shortSide);
  shadow.filter(BLUR, 4);
  shadow.endDraw();

  noStroke();
  fill(255);
  // image()でcreateGraphicsを描画
  // 影を描画
  image(shadow, -150+4, 4);
  // 本体の四角形を描画
  rect(-150, 0, longSide, shortSide);

  // 影を描画
  image(shadow, 150+4, 4);
  // 本体の四角形を描画
  rect(150, 0, longSide, shortSide);
}