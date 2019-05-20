// x軸方向の反転のこーど

int x, y;     // ボールの位置
int vx;   // ボールの速度
int ballSize; // ボールの大きさ

void setup() {
  size(960, 540);
  noStroke();
  fill(255);
  // ボールの初期値を設定
  x = width/2;
  y = height/2;
  vx = 3;
  // vy = 2;
  ballSize = 50;
}

void draw() {
  background(180);

  // ボールを描画
  ellipse(x, y, ballSize, ballSize);

  // ボールを動かす
  x += vx;
  // y += vy;

  // 左の壁にぶつかったら
  if (x <= 0) {
    vx *= -1; // x軸方向の速度反転
  }
  // 右の壁にぶつかったら
  if (x >= width) {
    vx *= -1; // x軸方向の速度反転
  }
}