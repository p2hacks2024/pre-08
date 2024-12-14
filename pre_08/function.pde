// スタート画面の描画
// スタートボタンのマウスオーバーチェック
boolean isMouseOverStartButton() {
  return dist(mouseX, mouseY, width / 2, height / 6*5+50) < 75;
}
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
// マウスクリックの処理
void mousePressed() {
  if (gmn == 0 && isMouseOverStartButton()) {
    player.play();
    player.rewind();
    gmn = 1; // 説明画面へ移動
  } else if (gmn == 1 && Overlap(mouseX,mouseY,0,0,width - 380, height - 300, 250, 120)) {
    player.play();
    player.rewind();
    gmn = 3; // 説明画面2枚目へ移動
  }else if(gmn == 1 && Overlap(mouseX,mouseY,0,0,130,height - 300,250,120)){
    gmn = 0; // タイトル画面に戻る
    player.play();
    player.rewind();
  }else if(gmn == 3 && Overlap(mouseX,mouseY,0,0,width - 380, height - 300, 250, 120)){
    gmn = 4; // 説明画面3枚目へ移動 
    player.play();
    player.rewind();
  }else if(gmn == 3 && Overlap(mouseX,mouseY,0,0,130,height - 300,250,120)){
    gmn = 1; // 説明画面1枚目に戻る
    player.play();
    player.rewind();
  }else if(gmn == 4 && Overlap(mouseX,mouseY,0,0,width - 380, height - 300, 250, 120)){
    int currentTime = millis();
    startTime = currentTime;
    gmn = 2; // ゲーム画面へ移動
    player.play();
    player.rewind();
    playerBGM1.close();
  }else if(gmn == 4 && Overlap(mouseX,mouseY,0,0,130,height - 300,250,120)){
    gmn = 3; // 説明画面2枚目に戻る
    player.play();
    player.rewind();
  } else if (gmn == 2) {
    if (gameEnded) return;
    float optionWidth = width * 0.35;
    float optionHeight = height * 0.1;
    float columnSpacing = width * 0.05;
    float centerX = width * 0.5;
    float leftColumnX = centerX - optionWidth - columnSpacing / 2;
    float rightColumnX = centerX + columnSpacing / 2;
    float firstRowY = height * 0.4;
    float secondRowY = height * 0.55;

    for (int i = 0; i < options[currentQuestion].length; i++) {
      float optionX = (i % 2 == 0) ? leftColumnX : rightColumnX;
      float optionY = (i < 2) ? firstRowY : secondRowY;

      if (mouseX > optionX && mouseX < optionX + optionWidth && mouseY > optionY && mouseY < optionY + optionHeight) {
        clickedAnswer = i;
        gameEnded = true;
        questionAnswered[currentQuestion] = true;
        questionResults[currentQuestion] = (clickedAnswer == correctAnswers[currentQuestion]);
        if (questionResults[currentQuestion]) {
          ans++;
          println(ans);
        }
        break;
      }
    }
  }
}

// ゲーム画面のみ
void keyPressed() {
  if (gameEnded && key == ' '&& total >= 10) {
    background(0); // 背景色
    gmn = 5;
  } else if (gameEnded && key == ' ') {
    total++;
    gameEnded = false;
    clickedAnswer = -1;
    elementIndex = 0;
    currentQuestion++;
    if (currentQuestion >= questions.length) {
      currentQuestion = 0; // 最初の問題に戻る
    }
    state = 1;
    startTime = millis();
  }
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
