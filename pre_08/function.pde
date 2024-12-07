void animateBulbs() {
  frameCounter++;
  if (frameCounter % 10 == 0) { // アニメーション速度を調整（10フレームごとに更新）
    if (glowing) {
      bulbStates[currentBulb] = true; // 現在の電球を光らせる
    } else {
      bulbStates[currentBulb] = false; // 現在の電球を消す
    }

    currentBulb++;
    if (currentBulb >= bulbCount) {
      currentBulb = 0; // 最初の電球に戻る
      glowing = !glowing; // 光る/消えるを切り替える
    }
  }

  drawBulbRing(width / 2, height / 2, 150, bulbCount);
}

void drawBulb(float x, float y, float width, float height, boolean isOn) {
  if (isOn) {
    image(bulbOnImage, x, y, width, height);
  } else {
    image(bulbOffImage, x, y, width, height);
  }
}

void drawStartScreen() {
  if (showRing) { // 電球リングを表示
    drawBulbRing(width / 2, height / 2, 150, bulbCount);
  }
  boolean hover = isMouseOverStartButton();
  fill(hover ? color(150, 0, 0) : color(255, 0, 0)); // ホバー時に暗くする
  ellipse(width / 2, height / 2, 200, 150); // ボタン
  fill(0);
  textAlign(CENTER, CENTER);
  text("スタート", width / 2, height / 2); // スタート文字
}

void drawWelcomeScreen() {
  fill(0);
  textAlign(CENTER, CENTER);
  text("ようこそ！", width / 2, height / 2);
}

void drawBulbRing(float x, float y, float radius, int count) {
  for (int i = 0; i < count; i++) {
    float angle = TWO_PI / count * i;
    float bx = x + cos(angle) * radius;
    float by = y + sin(angle) * radius;
    drawBulb(bx, by, 100, 100, bulbStates[i]);
  }
}

boolean isMouseOverStartButton() {
  return dist(mouseX, mouseY, width / 2, height / 2) < 100;
}

void mousePressed() {
  if (gmn == 0 && isMouseOverStartButton()) {
    gmn = 1;
    showRing = false; // 電球リングを非表示にする
  }
}
