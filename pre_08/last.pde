// グローバル変数
int inputNumber = ans; // ユーザーが入力する数値（デフォルトは10）
int bulbIndex = 0; // 電球のインデックス
int cnt = 0;//初期配置のためのもの
String resultMessage = "   　/10 問あなたは 正解しました。\n電球が点灯します。"; // 結果メッセージ
// テキストアニメーション用変数
int charIndex = 0; // 文字インデックス
int displaySpeed = 4; // テキスト表示速度
int frameCounter = 0; // フレームカウンター
// エフェクトや状態管理用変数
boolean flash = false; // 点滅エフェクト用フラグ
boolean showCongratulation = false; // おめでとうメッセージ表示フラグ
boolean showFinalMessage = false; // 最終メッセージ表示フラグ

// 点滅・カウントダウン管理用変数
int flashCounter = 0; // 点滅カウンター
int countdownTimer = 4; // カウントダウンタイマー
int countdownFrameCounter = 0; // カウントダウンフレームカウンター

// レインボーカラーエフェクト用変数
int rainbowCounter = 0;
void last(){
  inputNumber = ans;
  if(cnt == 0){
    displayInitialBulbs(); // 初期状態の電球を描画
    cnt =  1;
}
  if (flash && inputNumber == 10) {
    handleFlashEffect();
    return;
  }

  if (showCongratulation) {
    displayCongratulation();
    return;
  }

  displayBrainAge(); // 脳年齢の表示
  handleGameProgress(); // ゲームの進行状況処理
}
// 初期状態の電球を描画
void displayInitialBulbs() {
  for (int i = 0; i < 10; i++) {
    float xPosition = width / 10 * i + width / 20;
    image(light_normal, xPosition - light_normal.width / 8, height / 5 * 4 - light_normal.height / 8,light_normal.width / 4, light_normal.height / 4);
  }
  bulbIndex = 0;
}

// 点滅エフェクトの処理
void handleFlashEffect() {
  background(flashCounter % 10 < 5 ? 255 : 0); // 点滅
  flashCounter++;

  if (flashCounter > 120) {
    flash = false;
    showCongratulation = true;
  }
}

// おめでとうメッセージの表示
void displayCongratulation() {
  BGMfinal.play();
  background(0);
  rainbowCounter++;
  fill(color((rainbowCounter * 10) % 255, random(255), random(255)));
  textAlign(CENTER, CENTER);
  textSize(100);
  text("Congratulation!", width / 2, height / 2);
}

// 脳年齢を計算して表示
void displayBrainAge() {
  drawSpeechBubble(width / 2, height * 0.2, width * 0.8, height * 0.3);
  fill(0);
}

// ゲーム進行の管理
void handleGameProgress() {
  drawResultMessage();

  if (charIndex >= resultMessage.length()) {
    drawBulbs();
  }

  if (bulbIndex == inputNumber) {
    showFinalMessage = true;
  }

  if (showFinalMessage && inputNumber == 10) {
    displayFinalStage();
  }
}

// 最終ステージの処理
void displayFinalStage() {
  LastBGM.close();
  effectError.play();
  countdownFrameCounter++;

  if (countdownFrameCounter >= 20) {
    countdownTimer--;
    countdownFrameCounter = 0;
  }

  fill(random(255), random(255), random(255));
  textAlign(CENTER, CENTER);
  textSize(120);
  text("すべての電球が点灯しました\nフラッシュが起こります", width / 2, height * 0.50);

  if (countdownTimer <= 0) {
    flash = true;
    flashCounter = 0;
  }
}


// 吹き出しの描画
void drawSpeechBubble(float x, float y, float w, float h) {
  fill(255);
  stroke(255);
  strokeWeight(2);
  rectMode(CENTER);
  rect(x, y, w, h, 20);
}

// 結果メッセージのアニメーション表示
void drawResultMessage() {
  textSize(62);
  frameCounter++;

  if (frameCounter % displaySpeed == 0 && charIndex < resultMessage.length()) {
    charIndex++;
  }

  fill(random(30), 0, 0);
  textAlign(LEFT, TOP);
  text(ans, width / 2 - width * 0.34, height * 0.13);
  text(resultMessage.substring(0, charIndex), width / 2 - width * 0.34, height * 0.13);
}

// 電球の描画
void drawBulbs() {
  int totalBulbs = 10;
  float spacing = width / totalBulbs;
  float yPosition = height / 5 * 4;

  if (frameCounter % 10 == 0 && bulbIndex < ans) {
    bulbIndex++;
  }

  for (int i = 0; i < totalBulbs; i++) {
    float xPosition = spacing * i + spacing / 2;
    if (i < bulbIndex) {
      image(light_shine, xPosition - light_shine.width / 8, yPosition - light_shine.height / 8, light_shine.width / 4, light_shine.height / 4);
    } else {
      image(light_normal, xPosition - light_normal.width / 8, yPosition - light_normal.height / 8,light_normal.width / 4, light_normal.height / 4);
    }
  }
}
