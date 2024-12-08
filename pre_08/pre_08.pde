// グローバル変数
PImage NeonBulb;
PFont font; // 日本語フォント
String titleText = "QUIZGAME"; // タイトル文字列
int currentCharIndex = 0; // 現在表示する文字インデックス
int gmn = 0; // 画面管理変数 (0: タイトル, 1: 説明画面, 2: ゲーム画面)
boolean fadeOut = false; // フェードアウトのフラグ
float fadeAlpha = 255; // フェードの透明度
int displayTimer = 0; // 表示タイマー
float wobbleTime = 0;
float[] previousX = new float[5];  // 前フレームのX位置履歴
float[] previousY = new float[5];  // 前フレームのY位置履歴


void setup() {
  fullScreen();
  NeonBulb = loadImage("ネオンクイズ.png");
  font = createFont("Dialog.bold", 50);
  textFont(font);
  colorMode(RGB, 255);
  smooth();
  displayTimer = millis(); // タイマー初期化

  // 残像エフェクト初期化
  for (int i = 0; i < previousX.length; i++) {
    previousX[i] = 0;
    previousY[i] = 0;
  }
}

void draw() {
  background(0); // 背景色

  if (gmn == 0) {
    drawStartScreen(); // スタート画面を描画
  } else if (gmn == 1) {
    drawExplanationScreen(); // 説明画面を描画
  } else if (gmn == 2) {
    drawGameScreen(); // ゲーム画面を描画
  }
}
