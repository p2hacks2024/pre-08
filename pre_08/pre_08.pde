import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player,playerBGM1;
// グローバル変数
PImage NeonBulb;
PImage light_normal;
PImage light_shine;
PImage light_break;
PFont font; // 日本語フォント
String titleText = "FLASHQUIZ"; // タイトル文字列
int currentCharIndex = 0; // 現在表示する文字インデックス
int gmn = 0; // 画面管理変数 (0: タイトル, 1: 説明画面, 2: ゲーム画面)
boolean fadeOut = false; // フェードアウトのフラグ
float fadeAlpha = 255; // フェードの透明度
int displayTimer = 0; // 表示タイマー
float wobbleTime = 0;
float[] previousX = new float[5];  // 前フレームのX位置履歴
float[] previousY = new float[5];  // 前フレームのY位置履歴
float rotationAngleLeft = 0; // 左上光線の回転角度
float rotationAngleRight = 0; // 右上光線の回転角度;

void setup() {
  minim = new Minim(this);
  player = minim.loadFile("OnWord.mp3");//文字の効果音を読み込む
  playerBGM1 = minim.loadFile("BGM5.mp3");
  fullScreen();
  NeonBulb = loadImage("ネオンクイズ.PNG");
  light_normal = loadImage("電球　普通.PNG");
  light_shine = loadImage("電球　点灯.PNG");
  light_break = loadImage("電球　破損.PNG");
  font = createFont("Dialog.bold", 50);
  textFont(font);
  colorMode(RGB, 255);
  smooth();
  displayTimer = millis(); // タイマー初期化
}
void draw() {
  background(0); // 背景色

  if (gmn == 0) {
    drawStartScreen(); // スタート画面を描画
  } else if (gmn == 1) {
    drawExplanationScreen_1(); // 説明画面1枚目を描画
  } else if (gmn == 2) {
    drawGameScreen(); // ゲーム画面を描画
  } else if (gmn == 3) {
    drawExplanationScreen_2(); // 説明画面2枚目を描画
  } else if (gmn == 4) {
    drawExplanationScreen_3(); // 説明画面3枚目を描画
  }
}
