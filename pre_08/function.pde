void drawTitleScreen() {
  fill(0, 255, 255);
  // タイトル文字列を一文字ずつ描画
  if (millis() - displayTimer > 300 && currentCharIndex < titleText.length()) {
    currentCharIndex++;
    displayTimer = millis();
  }
  // 「QUIZ」の文字を左下から左上に配置してネオンエフェクト適用
  for (int i = 0; i < 4 && i < currentCharIndex; i++) {
    char c = titleText.charAt(i);
    float x = width / 4;
    float y = 0 + 200 + i * 100;
    Neon(x, y, 60, String.valueOf(c), color(random(255), random(255), random(255)));
  }
  // 「GAME」の文字を右上から右下に配置してネオンエフェクト適用
  for (int i = 4; i < 8 && i < currentCharIndex; i++) {
    char c = titleText.charAt(i);
    float x = width - width / 4;
    float y = 100 + (i - 4) * 100;
    Neon(x, y, 60, String.valueOf(c), color(random(255), random(255), random(255)));
  }
  // 全文字が表示されたら画像をフェード表示
  if (currentCharIndex == titleText.length()) {
    if (!fadeOut) {
      if (fadeAlpha < 255) fadeAlpha += 15;
    } else {
      if (fadeAlpha > 0) fadeAlpha -= 15;
    }
    tint(255, fadeAlpha);
    image(neonQuizImage, 0, 0, width, height / 6 * 5);
    if (fadeAlpha <= 0 || fadeAlpha >= 255) {
      fadeOut = !fadeOut;
    }
  }
  // スタートボタンの描画
  drawStartButton();
}

void drawStartButton() {
  boolean hover = isMouseOverStartButton();
  fill(hover ? color(0, 150, 0) : color(0, 255, 0));
  rect(width - 200, height - 100, 150, 50, 10);
  fill(255);
  Neon(width - 125, height - 75, 20, "スタート", color(0, 255, 255)); // ネオンエフェクト適用
}

void drawExplanationScreen() {
  fill(255);
  textSize(30);
  text("これはゲームです。\n画面の指示に従って楽しんでください！", width / 2, height / 2 - 50);
  fill(0, 255, 0);
  rect(width / 2 - 100, height / 2 + 50, 200, 50, 10);
  fill(255);
  text("ゲームスタート", width / 2, height / 2 + 75);
}

void drawGameScreen() {
  background(200, 220, 255);
  fill(0);
  textSize(50);
  text("ゲーム画面", width / 2, height / 2);
}

void mousePressed() {
  if (gmn == 0 && isMouseOverStartButton()) {
    gmn = 1;
  } else if (gmn == 1 && isMouseOverGameStartButton()) {
    gmn = 2;
  }
}

boolean isMouseOverStartButton() {
  return mouseX > width - 200 && mouseX < width - 50 && mouseY > height - 100 && mouseY < height - 50;
}

boolean isMouseOverGameStartButton() {
  return mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > height / 2 + 50 && mouseY < height / 2 + 100;
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
