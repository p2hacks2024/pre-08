// スタート画面の描画
void drawStartScreen() {
  drawBulbRing(width / 2, height / 2, innerRingRadius, innerBulbCount, innerBulbStates);
  drawBulbRing(width / 2, height / 2, outerRingRadius, outerBulbCount, outerBulbStates);

  boolean hover = isMouseOverStartButton();
  fill(hover ? color(150, 0, 0) : color(255, 0, 0));
  ellipse(width / 2, height / 2, 150, 100);

  // ネオン文字で「スタート」を描画
  Neon(width / 2, height / 2, 50, "スタート", color(0, 255, 255));
}

// 説明画面の描画
void drawExplanationScreen() {
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("これはゲームです。\nボタンをクリックしてゲームを始めてください！", width / 2, height / 2 - 50);

  // ゲームスタートボタン
  boolean hover = isMouseOverGameStartButton();
  fill(hover ? color(0, 150, 0) : color(0, 255, 0));
  rect(width / 2 - 100, height / 2 + 50, 200, 100, 20);

  fill(255);
  textSize(30);
  text("ゲームスタート", width / 2, height / 2 + 100);
}

// ゲーム画面の描画
void drawGameScreen() {
  background(200, 220, 255); // ゲーム用の背景色
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("ゲーム画面へようこそ！", width / 2, height / 2);
}

// 電球アニメーション
void animateBulbs() {
  // 一定時間で奇数・偶数を切り替え
  if (millis() - bulbSwitchTimer > 1000) {
    bulbSwitchTimer = millis();
    showOddBulbs = !showOddBulbs;
  }

  // 内側リングの電球状態を設定
  for (int i = 0; i < innerBulbCount; i++) {
    innerBulbStates[i] = (showOddBulbs && i % 2 == 0) || (!showOddBulbs && i % 2 != 0);
  }

  // 外側リングの電球状態を設定
  for (int i = 0; i < outerBulbCount; i++) {
    int shiftedIndex = (i + 1) % outerBulbCount;
    outerBulbStates[i] = innerBulbStates[shiftedIndex % innerBulbCount];
  }

  // リングを描画
  drawBulbRing(width / 2, height / 2, innerRingRadius, innerBulbCount, innerBulbStates);
  drawBulbRing(width / 2, height / 2, outerRingRadius, outerBulbCount, outerBulbStates);
}

// 電球リングを描画
void drawBulbRing(float x, float y, float radius, int count, boolean[] states) {
  for (int i = 0; i < count; i++) {
    float angle = TWO_PI / count * i;
    float bx = x + cos(angle) * radius;
    float by = y + sin(angle) * radius;
    drawBulb(bx, by, bulbSize, bulbSize, states[i]);
  }
}

// 電球を描画
void drawBulb(float x, float y, float width, float height, boolean isOn) {
  if (isOn) {
    image(bulbOnImage, x - width / 2, y - height / 2, width, height);
  } else {
    image(bulbOffImage, x - width / 2, y - height / 2, width, height);
  }
}

// マウスクリックの処理
void mousePressed() {
  if (gmn == 0 && isMouseOverStartButton()) {
    gmn = 1; // 説明画面へ移動
  } else if (gmn == 1 && isMouseOverGameStartButton()) {
    gmn = 2; // ゲーム画面へ移動
  }
}

// スタートボタンのマウスオーバーチェック
boolean isMouseOverStartButton() {
  return dist(mouseX, mouseY, width / 2, height / 2) < 75;
}

// ゲームスタートボタンのマウスオーバーチェック
boolean isMouseOverGameStartButton() {
  return mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > height / 2 + 50 && mouseY < height / 2 + 150;
}

// ネオン効果を描画
void Neon(float x, float y, float size, String string, color mainColor) {
  PFont japaneseFont = createFont("Dialog.bold", size); // 日本語対応フォント
  textFont(japaneseFont);
  textAlign(CENTER, CENTER);

  wobbleTime += 0.1;
  float wobbleAmount = size * 0.035;

  // 残像エフェクトの更新
  for (int i = previousX.length - 1; i > 0; i--) {
    previousX[i] = previousX[i - 1];
    previousY[i] = previousY[i - 1];
  }

  float wobbleX = x + sin(wobbleTime * 0.5) * wobbleAmount;
  float wobbleY = y + cos(wobbleTime * 0.5) * wobbleAmount;

  previousX[0] = wobbleX;
  previousY[0] = wobbleY;

  // 残像を描画
  for (int i = 1; i < previousX.length; i++) {
    float alfa = map(i, 1, previousX.length, 40, 10);
    color shadowColor = color(red(mainColor), green(mainColor), blue(mainColor), alfa);

    for (int blur = 1; blur <= 3; blur++) {
      fill(shadowColor, alfa / blur);
      textSize(size * (1 - blur * 0.05));
      text(string, previousX[i] + blur, previousY[i] + blur);
      text(string, previousX[i] - blur, previousY[i] - blur);
    }
  }

  // メインの文字を描画
  fill(mainColor, 230);
  text(string, wobbleX, wobbleY);

  // グロー効果を描画
  for (int glow = 1; glow <= 3; glow++) {
    noFill();
    stroke(mainColor, 30 / glow);
    strokeWeight(size / (20 * glow));
    text(string, x, y);
  }
}
