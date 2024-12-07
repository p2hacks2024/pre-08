
void animateBulbs() {
  // 1秒ごとに点灯パターンを切り替え
  if (millis() - bulbSwitchTimer > 1000) {
    bulbSwitchTimer = millis();
    showOddBulbs = !showOddBulbs; // 奇数・偶数を切り替え
  }

  // 内側リングの状態更新
  for (int i = 0; i < innerBulbCount; i++) {
    innerBulbStates[i] = (showOddBulbs && i % 2 == 0) || (!showOddBulbs && i % 2 != 0);
  }

  // 外側リングの状態更新（内側から1つずらす）
  for (int i = 0; i < outerBulbCount; i++) {
    int shiftedIndex = (i + 1) % outerBulbCount; // 1つずらす
    outerBulbStates[i] = innerBulbStates[shiftedIndex % innerBulbCount];
  }

  // 電球リング描画
  drawBulbRing(width / 2, height / 2, innerRingRadius, innerBulbCount, innerBulbStates);
  drawBulbRing(width / 2, height / 2, outerRingRadius, outerBulbCount, outerBulbStates);
}

void drawBulbRing(float x, float y, float radius, int count, boolean[] states) {
  for (int i = 0; i < count; i++) {
    float angle = TWO_PI / count * i;
    float bx = x + cos(angle) * radius;
    float by = y + sin(angle) * radius;
    drawBulb(bx, by, bulbSize, bulbSize, states[i]);
  }
}

void drawBulb(float x, float y, float width, float height, boolean isOn) {
  if (isOn) {
    image(bulbOnImage, x - width / 2, y - height / 2, width, height); // 中心を基準に配置
  } else {
    image(bulbOffImage, x - width / 2, y - height / 2, width, height);
  }
}

void drawStartScreen() {
  // 電球リングの描画
  drawBulbRing(width / 2, height / 2, innerRingRadius, innerBulbCount, innerBulbStates);
  drawBulbRing(width / 2, height / 2, outerRingRadius, outerBulbCount, outerBulbStates);

  // スタートボタンの描画
  boolean hover = isMouseOverStartButton();
  fill(hover ? color(150, 0, 0) : color(255, 0, 0)); // ホバー時に暗くする
  ellipse(width / 2, height / 2, 150, 100); // ボタン
  fill(0);
  textAlign(CENTER, CENTER);
  text("スタート", width / 2, height / 2); // スタート文字
}

void drawWelcomeScreen() {
  fill(0);
  textAlign(CENTER, CENTER);
  text("ようこそ！", width / 2, height / 2);
}

void drawQuizText() {
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("クイズ", width / 2, 50); // 上部に「クイズ」を表示
}

boolean isMouseOverStartButton() {
  return dist(mouseX, mouseY, width / 2, height / 2) < 75;
}

void mousePressed() {
  if (gmn == 0 && isMouseOverStartButton()) {
    gmn = 1; // ゲーム開始
    // 電球をすべて消灯
    for (int i = 0; i < innerBulbCount; i++) innerBulbStates[i] = false;
    for (int i = 0; i < outerBulbCount; i++) outerBulbStates[i] = false;
  }
}
