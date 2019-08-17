void setup() {
  size(960, 540);
  noLoop();
  stroke(0);
  strokeWeight(2);
}

void draw() {
  background(255);
  // 左端から右端まで5px間隔で表示
  for(int x = 0; x <= width; x += 5) {
    // y座標をrandomで変動
    float y = height - random(height);
    line(x , height, x, y);
  }
}

void keyPressed() {
  redraw();
}
