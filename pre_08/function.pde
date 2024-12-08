// スタート画面の描画
// 旭日旗効果を描画
void drawRisingSunEffect() {
  pushMatrix();
  translate(0, height ); // 左上に移動
  drawRotatingLines(rotationAngleLeft);
  popMatrix();

  pushMatrix();
  translate(width, height ); // 右上に移動
  drawRotatingLines(rotationAngleRight);
  popMatrix();

  rotationAngleLeft += 0.02; // 回転速度を設定
  rotationAngleRight -= 0.02; // 回転速度を設定
}

// 回転する光線を描画
void drawRotatingLines(float angle) {
  noStroke();
  for (int i = 0; i < 16; i++) {
    float theta = angle + radians(i * 360 / 16);
    float x1 = cos(theta) * 300;
    float y1 = sin(theta) * 300;
    float x2 = cos(theta + radians(10)) * 300;
    float y2 = sin(theta + radians(10)) * 300;

    fill(color(random(255), random(255), random(255), 150));
    beginShape();
    vertex(0, 0);
    vertex(x1*2, y1*2);
    vertex(x2*2, y2*2);
    endShape(CLOSE);
  }
}

void drawStartScreen() {
  if (millis() - displayTimer > 200 && currentCharIndex < titleText.length()) {
    currentCharIndex++;
    displayTimer = millis();
  }
  // 「QUIZ」の文字を左下から左上に配置してネオンエフェクト適用
  for (int i = 0; i < 5 && i < currentCharIndex; i++) {
    char c = titleText.charAt(i);
    float x = width / 9 + (i-1) * 100;
    float y =  200 ;
    Neon(x, y, 90, String.valueOf(c), color(random(255), random(255), random(255)));
    if (currentCharIndex >= 3) {
    }
  }


  // 「GAME」の文字を右上から右下に配置してネオンエフェクト適用
  for (int i = 5; i < 9 && i < currentCharIndex; i++) {
    char c = titleText.charAt(i);
    float x = width/ 9 * 4 + (i-1) * 100;
    float y = 200 ;
    Neon(x, y, 90, String.valueOf(c), color((i*255), random(255), random(255)));
    if (currentCharIndex == titleText.length()-1) {
    }
  }
  // 全文字が表示されたら画像をフェード表示
  if (currentCharIndex == titleText.length()) {
    if (!fadeOut) {
      if (fadeAlpha < 255) fadeAlpha += 15;
    } else {
      if (fadeAlpha > 0) fadeAlpha -= 15;
    }
    drawRisingSunEffect(); // 旭日旗効果を描画
    tint(255, fadeAlpha);
    image(NeonBulb, 0, 0, width, height / 6 * 5);
    if (fadeAlpha <= 0 || fadeAlpha >= 255) {
      fadeOut = !fadeOut;
    }
    boolean hover = isMouseOverStartButton();
    fill(hover ? color(0, 255, 0) : color(255, 255, 255));
    ellipse(width / 2, height / 6*5+50, 200, 100);
    // ネオン文字で「スタート」を描画
    Neon(width / 2, height / 6*5+50, 50, "スタート", color(random(255), random(255), random(255)));
  }
}

// 説明画面の描画
void drawExplanationScreen() {
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("これはゲームです。\nボタンをクリックしてゲームを始めてください！", width / 2, height / 2 - 50);
  // ゲームスタートボタン
  fill(0, 255, 0);
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
  return dist(mouseX, mouseY, width / 2, height / 6*5+50) < 75;
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
  float wobbleAmount = size * 0.03;
  float wobbleX = x + sin(wobbleTime * 0.5) * wobbleAmount;
  float wobbleY = y + cos(wobbleTime * 0.5) * wobbleAmount;

  previousX[0] = wobbleX;
  previousY[0] = wobbleY;

  // メインの文字を描画g
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
