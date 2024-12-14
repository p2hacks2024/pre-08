import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player, playerBGM1, GameBGM,LastBGM,BGMfinal, effect1, effect2, effect3,effectError;
// グローバル変数
PImage NeonBulb;
PImage light_normal;
PImage light_shine;
PImage light_break;
PImage example_1;
PImage example_2;
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
float rotationAngleRight = 0; // 右上光線の回転角度

// ゲーム画面
int clickedAnswer = -1;
int currentQuestion = 0;
int state = 1;
int startTime;
int elementIndex = 0;
boolean gameEnded = false;
int ans = 0;
int total = 1, effect = 0;

int[] correctAnswers = {2, 1, 2, 1, 2, 0, 3, 0, 2, 0}; // 各問題の正解のインデックス
boolean[] questionAnswered = new boolean[10];
boolean[] questionResults = new boolean[10];
color[] optionBorderColors = {color(0, 0, 255), color(0, 255, 0), color(255, 0, 0), color(255, 255, 0)}; // 四角の枠線色
// 問題文データ
String[] questions = {
  "全部の脚は何本？",
  "全部で何個？",
  "全部で何人？",
  "すべてかけ合わせると？",
  "何年の流行語？",
  "制作者は？",
  "制作者は？",
  "鳥ではない生物は何匹？",
  "組み合わせてできる漢字は？",
  "何の花言葉？"
};
// 選択肢データ
String[][] options = {
  {"20本", "25本", "30本", "35本"},
  {"12個", "15個", "18個", "21個"},
  {"1人", "2人", "3人", "4人"},
  {"150", "200", "250", "300"},
  {"2018年", "2019年", "2020年", "2021年"},
  {"アンデルセン", "イソップ", "グリム", "ルイスキャロル"},
  {"宮崎翔", "宮崎楓", "宮崎蛍", "宮崎駿"},
  {"1", "2", "3", "いない"},
  {"眺", "蝶", "聴", "週"},
  {"マリーゴールド", "黄色のチューリップ", "赤いガーベラ", "13本のバラ"}
};
// フラッシュデータ
String[][] elements = {
  {"タコ", "イカ", "クモ", "シマウマ"},
  {"雪見だいふく", "ピノ", "からあげクン", "パピコ"},
  {"鈴木一朗", "ラーメン二郎", "北島三郎", "天草四郎"},
  {"5", "10", "2", "2"},
  {"3密", "愛の不時着", "あつ森", "アベノマスク"},
  {"みにくいアヒルの子", "裸の王様", "人魚姫", "マッチ売りの少女"},
  {"となりのトトロ", "千と千尋の神隠し", "もののけ姫", "崖の上のポニョ"},
  {"にわとり", "うみねこ", "ちりとり", "ぺんぎん"},
  {"耳", "心", "十", "目"},
  {"絶望", "健康", "変わらぬ愛", "嫉妬"}
};
// 花火
ArrayList<HashMap<String, Object>> fireworks;
// 雷
ArrayList<HashMap<String, Object>> lightnings;

void setup() {
  minim = new Minim(this);
  player = minim.loadFile("OnWord.mp3");//文字の効果音を読み込む
  playerBGM1 = minim.loadFile("BGM5.mp3");
  GameBGM = minim.loadFile("BGM7.mp3");
  LastBGM = minim.loadFile("BGMlast.mp3");
  BGMfinal = minim.loadFile("BGMfinal.mp3");
  effect1 = minim.loadFile("電球割れ.mp3");
  effect2 = minim.loadFile("正解音.mp3");
  effect3 = minim.loadFile("出題音.mp3");
  effectError = minim.loadFile("ゲーム・レース開始.mp3");
  fullScreen();
  NeonBulb = loadImage("ネオンクイズ.png");
  light_normal = loadImage("電球　普通.PNG");
  light_shine = loadImage("電球　点灯.PNG");
  light_break = loadImage("電球　破損.PNG");
  example_1 = loadImage("1234.PNG");
  example_2 = loadImage("例題.PNG");
  font = createFont("Dialog.bold", 50);
  textFont(font);
  colorMode(RGB, 255);
  smooth();
  displayTimer = millis(); // タイマー初期化
  background(0); // 背景色
  fireworks = new ArrayList<HashMap<String, Object>>();
  lightnings = new ArrayList<HashMap<String, Object>>();
}
void draw() {
  if (gmn == 0) {
    background(0); // 背景色
    drawStartScreen(); // スタート画面を描画
  } else if (gmn == 1) {
    background(0); // 背景色
    drawExplanationScreen_1(); // 説明画面1枚目を描画
  } else if (gmn == 2) {
    GameBGM.play();
    GameBGM.setGain(-10.0);
    background(0); // 背景色
    drawGameScreen(); // ゲーム画面を描画
  } else if (gmn == 3) {
    background(0); // 背景色
    drawExplanationScreen_2(); // 説明画面2枚目を描画
  } else if (gmn == 4) {
    background(0); // 背景色
    drawExplanationScreen_3(); // 説明画面3枚目を描画
  } else if (gmn == 5) {
    GameBGM.close();
    LastBGM.play();
    last();
  }
}
