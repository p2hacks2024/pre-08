// グローバル変数
PImage neonQuizImage; // ネオンクイズのイラスト画像
PFont font; // 日本語フォント
String titleText = "QUIZGAME"; // タイトル文字列
int currentCharIndex = 0; // 現在表示する文字インデックス
int gmn = 0; // 画面管理変数 (0: タイトル, 1: 説明画面, 2: ゲーム画面)
boolean showImage = false; // 画像の表示フラグ
boolean fadeOut = false; // フェードアウトのフラグ
float fadeAlpha = 255; // フェードの透明度
int displayTimer = 0; // 表示タイマー

// Neon効果用の新しいグローバル変数
float wobbleTime = 0;
int trailLength = 10;
float[] previousX = new float[trailLength];
float[] previousY = new float[trailLength];

void setup() {
  fullScreen();
  neonQuizImage = loadImage("ネオンクイズ.PNG");
  font = createFont("Dialog.bold", 60);
  textFont(font);
  textAlign(CENTER, CENTER);
  frameRate(60);
  displayTimer = millis(); // タイマー初期化
}

void draw() {
  background(0);
  if (gmn == 0) {
    drawTitleScreen();
  } else if (gmn == 1) {
    drawExplanationScreen();
  } else if (gmn == 2) {
    drawGameScreen();
  }
}
