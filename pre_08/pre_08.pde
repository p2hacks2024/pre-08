PImage bulbOffImage; // 光っていない電球画像
PImage bulbOnImage;  // 光っている電球画像
int gmn = 0; // 画面を管理する関数
PFont font; // 日本語フォント
int bulbCount = 10; // 電球の数
boolean[] bulbStates; // 電球の状態を管理するリスト
int currentBulb = 0; // 現在制御している電球のインデックス
boolean glowing = true; // 電球が光る方向（trueなら光る、falseなら消える）
int frameCounter = 0; // アニメーション用のフレームカウンタ
boolean showRing = true; // 電球リングを表示するかどうかを管理

void setup() {
  fullScreen(); // ウィンドウサイズ
  bulbOffImage = loadImage("電球.PNG"); // 光っていない電球画像をロード
  bulbOnImage = loadImage("電球点灯.PNG"); // 光っている電球画像をロード
  font = createFont("Dialog.bold", 50); // 日本語フォントをロード
  textFont(font);
  bulbStates = new boolean[bulbCount]; // 電球の状態を初期化
}

void draw() {
  background(255); // 背景を設定
  if (gmn == 0) {
    drawStartScreen();
    if (showRing) animateBulbs();
  } else if (gmn == 1) {
    drawWelcomeScreen();
  }
}
