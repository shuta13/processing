// 初期化用関数
void setup() {
    size(800, 800);
    background(0, 0, 0);
}

// Main関数(Loop)
void draw() {
    // 背景色の設定
    // 白で塗りつぶす
    fill(255, 255, 255);
    // 中心に大きさ10の円を描画
    ellipse(width / 2, height / 2, 10, 10);
}
