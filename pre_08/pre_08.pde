PImage bulbImage;
int gmn = 0;//画面を管理する関数
PFont font; // 日本語フォント
void setup() {
  fullScreen(); // ウィンドウサイズ
  bulbImage = loadImage("lightbulb.png"); // 電球画像をロード
  font = createFont("Dialog.bold",50); // 作成した日本語フォントをロード
  textFont(font);
}

void draw() {
  background(255); // 背景を設定
  if (gmn == 0) {
    drawStartScreen();
  } else if (gmn == 1) {
    drawWelcomeScreen();
  }
}
