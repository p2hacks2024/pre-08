
// グローバル変数
PImage bulbOffImage; // 光っていない電球画像
PImage bulbOnImage;  // 光っている電球画像
PImage NeonImage;
int gmn = 0; // 画面を管理するフラグ (0: スタート画面, 1: 説明画面, 2: ゲーム画面)
PFont font; // 日本語フォント
int innerBulbCount = 8; // 内側の電球数
int outerBulbCount = 12; // 外側の電球数
boolean[] innerBulbStates; // 内側電球の状態
boolean[] outerBulbStates; // 外側電球の状態
boolean showOddBulbs = true; // 奇数電球を点灯フラグ
float innerRingRadius = 250; // 内側リングの半径
float outerRingRadius = 350; // 外側リングの半径
int bulbSwitchTimer = 0; // 電球の点灯切り替えタイマー
int bulbSize = 100; // 電球のサイズ
float wobbleTime = 0;  // 揺れのアニメーション用タイマー
float[] previousX = new float[5];  // 前フレームのX位置履歴
float[] previousY = new float[5];  // 前フレームのY位置履歴

void setup() {
  fullScreen();
  bulbOffImage = loadImage("電球.PNG");
  bulbOnImage = loadImage("電球点灯.PNG");
  NeonImage = loadImage("ネオンクイズ.PNG");
  font = createFont("Dialog.bold", 50);
  textFont(font);
  colorMode(RGB, 255);
  smooth();

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
