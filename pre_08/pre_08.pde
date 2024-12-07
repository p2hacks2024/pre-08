PImage bulbOffImage; // 光っていない電球画像
PImage bulbOnImage;  // 光っている電球画像
int gmn = 0; // 画面を管理するフラグ
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

void setup() {
  fullScreen(); // ウィンドウサイズ
  bulbOffImage = loadImage("電球.PNG"); // 光っていない電球画像をロード
  bulbOnImage = loadImage("電球点灯.PNG"); // 光っている電球画像をロード
  font = createFont("Dialog.bold", 50); // 日本語フォントをロード
  textFont(font);
  innerBulbStates = new boolean[innerBulbCount]; // 内側電球の状態を初期化
  outerBulbStates = new boolean[outerBulbCount]; // 外側電球の状態を初期化
}

void draw() {
  background(255); // 背景色
  drawQuizText(); // クイズのタイトルを表示

  if (gmn == 0) {
    drawStartScreen();
    animateBulbs();
  } else if (gmn == 1) {
    drawWelcomeScreen();
  }
}
