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

void drawStartScreen() {
  if (millis() - displayTimer > 100 && currentCharIndex < titleText.length()) {
    currentCharIndex++;
    displayTimer = millis();
  }
  // 「QUIZ」の文字を左下から左上に配置してネオンエフェクト適用
  for (int i = 0; i < 5 && i < currentCharIndex; i++) {
    char c = titleText.charAt(i);
    float x = width / 9 + (i-1) * 100;
    float y =  200 ;
    Neon(x, y, 90, String.valueOf(c), color(random(255), random(255), random(255)));
  }


  // 「GAME」の文字を右上から右下に配置してネオンエフェクト適用
  for (int i = 5; i < 9 && i < currentCharIndex; i++) {
    char c = titleText.charAt(i);
    float x = width/ 9 * 4 + (i-1) * 110;
    float y = 200 ;
    Neon(x, y, 90, String.valueOf(c), color((i*255), random(255), random(255)));
    if (currentCharIndex == titleText.length()-3) {
      playerBGM1.play();
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

// 説明画面１枚目の描画
void drawExplanationScreen_1() {
  String title = "ルール説明";
  int lightsize = 240;
  drawRisingSunEffect();
  fill(17, 67, 72);
  textSize(150);
  text(title,width/2-300,80);
  fill(67,18,62);
  text(title,width/2-600,60);
  fill(67,65,18);
  text(title,width/2+300,80);
  fill(18,67,34);
  text(title,width/2+600,60);
  
  tint(255,64);
  image(NeonBulb, 0, 0, width, height / 6 * 5);
  tint(255, 255);
  image(light_shine, width/2-(lightsize+(lightsize/2)), 160, lightsize, lightsize);
  image(light_normal, width/2-(lightsize/2), 160, lightsize, lightsize);
  image(light_normal, width/2+(lightsize/2), 160, lightsize, lightsize);
  Neon(width/2, 100, 150, title, color(random(255), 255, random(255)));
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  text("このゲームは反射神経、観察力をためすゲームです。\nまた、脳年齢を測定します。\n制限時間内に出題された問題の正しい答えを選んでください。\n出題される問題は全部で10問です。\n", width/2, height/2 + 60);

  fill(0, 255, 0);
  stroke(255,255,0);
  rect(width - 380, height - 300, 250, 120, 20);
  rect(130,height - 300,250,120,20);

  fill(255);
  textSize(30);
  text("次へ", width - 255, height -490 + 250);
  text("タイトル画面へ", 255,height-490+250);
}

// 説明画面2枚目の描画
void drawExplanationScreen_2() {
  String title2 = "ルール説明";
  int lightsize = 240;
  drawRisingSunEffect();
  fill(17, 67, 72);
  textSize(150);
  text(title2, width/2-300, 80);
  fill(67, 18, 62);
  text(title2, width/2-600, 60);
  fill(67, 65, 18);
  text(title2, width/2+300, 80);
  fill(18, 67, 34);
  text(title2, width/2+600, 60);
  tint(255, 64);
  image(NeonBulb, 0, 0, width, height / 6 * 5);
  tint(255, 255);
  image(light_shine, width/2-(lightsize+(lightsize/2)), 160, lightsize, lightsize);
  image(light_shine, width/2-(lightsize/2), 160, lightsize, lightsize);
  image(light_normal, width/2+(lightsize/2), 160, lightsize, lightsize);
  Neon(width/2, 100, 150, title2, color(random(255), 255, random(255)));


  stroke(255);
  rect(width/2-(960/2), height/2-150, 960, 300);
  image(example_1,width/2-(960/2), height/2-150);
  fill(0, 255, 0);
  stroke(255,255,0);
  rect(width - 380, height - 300, 250, 120, 20);
  rect(130,height - 300,250,120,20);

  fill(255);
  textSize(30);
  text("次へ", width - 255, height -490 + 250);
  text("前へ", 255,height-490+250);
  textSize(40);
  text("例：",width/2-(960/2)-50, height/2-200);
  text("まず最初に４つの単語が１秒ずつ出てきます。\n思ったよりも早いので集中して見てね。", width/2, height/2+210);
  
}

// 説明画面３枚目の描画
void drawExplanationScreen_3() {
  String title3 = "ルール説明";
  int lightsize = 240;
  drawRisingSunEffect();
  fill(17, 67, 72);
  textSize(150);
  text(title3, width/2-300, 80);
  fill(67, 18, 62);
  text(title3, width/2-600, 60);
  fill(67, 65, 18);
  text(title3, width/2+300, 80);
  fill(18, 67, 34);
  text(title3, width/2+600, 60);
  tint(255, 64);
  image(NeonBulb, 0, 0, width, height / 6 * 5);
  tint(255, 255);
  image(light_shine, width/2-(lightsize+(lightsize/2)), 160, lightsize, lightsize);
  image(light_shine, width/2-(lightsize/2), 160, lightsize, lightsize);
  image(light_shine, width/2+(lightsize/2), 160, lightsize, lightsize);
  Neon(width/2, 100, 150, title3, color(random(255), 255, random(255)));


  stroke(255);
  rect(width/2-(960/2), height/2-200, 960, 540);
  image(example_2,width/2-(960/2), height/2-200, 960, 540);
  
  fill(255, 0, 0);
  stroke(255,255,0);
  rect(width - 380, height - 300, 250, 120, 20);
  fill(0, 255, 0);
  stroke(255,255,0);
  rect(130,height - 300,250,120,20);

  fill(255);
  textSize(30);
  text("開始！", width - 255, height -490 + 250);
  text("前へ", 255,height-490+250);
  textSize(40);
  text("例：",width/2-(960/2)-50, height/2-200);
  text("制限時間",width/2+420, height/2-270);
  stroke(255);
  line(width/2+230, height/2-143, width/2+350, height/2-240);
  text("次にその４つの単語に関する問題が出題されます。\n４つの選択肢の中から正しい答えを選んでください。\nこれを１０回繰り返します。\n最後に結果が表示されます。", width/2, height-155);
  
}

void drawGameScreen() {
  background(0); // 背景は黒
  int currentTime = millis();

  if (state == 1) {
    // 最初の3秒間「第〇問」を表示
    if (currentTime - startTime < 2000) {
      textSize(200);
      fill(255);
      textAlign(CENTER, CENTER);
      text("第" + (currentQuestion + 1) + "問", width / 2, height / 2);
    } else {
      state = 2;
      startTime = currentTime;
    }
  } else if (state == 2) {
    effect1.rewind();
    effect2.rewind();
    // 各要素を1秒ずつ表示
    if (currentTime - startTime < 1000) {
      textSize(200);
      fill(255);
      textAlign(CENTER, CENTER);
      text(elements[currentQuestion][elementIndex], width / 2, height / 2);
    } else {
      elementIndex++;
      startTime = currentTime;
      if (elementIndex >= elements[currentQuestion].length) {
        state = 3; // 表示終了
        startTime = currentTime; // 次の状態に移るために時間をリセット
      }
    }
  } else if (state == 3) {
    // 元のコードに移動
    background(0); // 背景は黒

    // 問題部分
    fill(255, 255, 255);
    stroke(255);
    strokeWeight(4);
    rect(width * 0.2, height * 0.2, width * 0.6, height * 0.1, 10);

    // 「〇」の表示　→第何問目か
    fill(255, 0, 255);
    textSize(64);
    text((currentQuestion + 1), width * 0.22, height * 0.25); // 間違ってるかも

    // 問題文の表示
    fill(0);
    textSize(64);
    text(questions[currentQuestion], width * 0.5, height * 0.25);

    // 問題文の両サイドに画像を表示
    float sideImageWidth = width * 0.15;
    float sideImageHeight = height * 0.2;
    float sideImageXLeft = width * 0.005;
    float sideImageXRight = width - sideImageWidth; // 左右対称にするために右側の位置を調整
    if (gameEnded) {
      if (clickedAnswer == correctAnswers[currentQuestion]) {
        effect2.play();
        image(light_shine, sideImageXLeft, height * 0.1, sideImageWidth, sideImageHeight); // 正解時の画像
        image(light_shine, sideImageXRight, height * 0.1, sideImageWidth, sideImageHeight); // 正解時の画像
      } else {
        effect1.play();
        image(light_break, sideImageXLeft, height * 0.1, sideImageWidth, sideImageHeight); // 不正解時の画像
        image(light_break, sideImageXRight, height * 0.1, sideImageWidth, sideImageHeight); // 不正解時の画像
      }
    } else {
      image(light_normal, sideImageXLeft, height * 0.1, sideImageWidth, sideImageHeight); // 通常の画像
      image(light_normal, sideImageXRight, height * 0.1, sideImageWidth, sideImageHeight); // 通常の画像
    }

    // 選択肢部分（2列配置、中央揃え）
    float optionWidth = width * 0.35;
    float optionHeight = height * 0.1;
    float columnSpacing = width * 0.05; // 列間の余白
    float rowSpacing = height * 0.05;  // 行間の余白
    float centerX = width * 0.5;
    float leftColumnX = centerX - optionWidth - columnSpacing / 2;
    float rightColumnX = centerX + columnSpacing / 2;
    float firstRowY = height * 0.4;
    float secondRowY = height * 0.55;

    for (int i = 0; i < options[currentQuestion].length; i++) {
      float optionX = (i % 2 == 0) ? leftColumnX : rightColumnX;
      float optionY = (i < 2) ? firstRowY : secondRowY;

      // 四角形の描画
      noFill(); // 塗りつぶしなし
      if (!gameEnded) {
        if (mouseX > optionX && mouseX < optionX + optionWidth && mouseY > optionY && mouseY < optionY + optionHeight) {
          stroke(255);
        } else {
          stroke(optionBorderColors[i]);
        }
      } else {
        if (i == correctAnswers[currentQuestion]) {
          stroke(255, 0, 0); // 正解の選択肢は赤
        } else {
          stroke(0, 0, 255); // 不正解の選択肢は青
        }
      }
      strokeWeight(3);
      rect(optionX, optionY, optionWidth, optionHeight, 10);

      // テキスト描画
      fill(255);
      textSize(53);
      text(options[currentQuestion][i], optionX + optionWidth / 2, optionY + optionHeight / 2);

      // 〇と×の表示
      if (gameEnded) {
        if (i == correctAnswers[currentQuestion]) {
          fill(255, 0, 0);
          textSize(64);
          text("〇", optionX + 40, optionY + optionHeight / 2);
        } else {
          fill(0, 0, 255);
          textSize(64);
          text("×", optionX + 40, optionY + optionHeight / 2);
        }
      }
    }

    // 画像の表示
    float imageHeight = height * 0.15;
    for (int i = 0; i < 10; i++) {
      if (i == currentQuestion && gameEnded) {
        if (clickedAnswer == correctAnswers[currentQuestion]) {
          image(light_shine, width * 0.1 * i, height * 0.8, width * 0.1, imageHeight); // 正解時の画像
        } else {
          image(light_break, width * 0.1 * i, height * 0.8, width * 0.1, imageHeight); // 不正解時の画像
        }
      } else if (questionAnswered[i]) {
        if (questionResults[i]) {
          image(light_shine, width * 0.1 * i, height * 0.8, width * 0.1, imageHeight); // 正解時の画像
        } else {
          image(light_break, width * 0.1 * i, height * 0.8, width * 0.1, imageHeight); // 不正解時の画像
        }
      } else {
        image(light_normal, width * 0.1 * i, height * 0.8, width * 0.1, imageHeight); // 通常の画像
      }
    }

    // タイムバー部分
    float barX = width * 0.2;
    float barY = height * 0.1;
    float barWidth = width * 0.6;
    float barHeight = 10;

    fill(255);
    rect(barX, barY, barWidth, barHeight);

    if (!gameEnded) {
      fill(255, 255, 0);
      float elapsedTime = (millis() - startTime) / 1000.0; // 経過時間を秒に変換
      float progress = map(elapsedTime, 0, 4, barX, barX + barWidth);

      // 時間が過ぎたとこがカラフルになる
      color[] colors = {
        color(255, 0, 0), // 赤
        color(255, 165, 0), // オレンジ
        color(255, 255, 0), // 黄色
        color(0, 255, 0), // 緑
        color(0, 0, 255), // 青
        color(75, 0, 130), // インディゴ
        color(238, 130, 238) // 紫
      };

      int numColors = colors.length;
      float segment = 4.0 / (numColors - 1);
      color currentColor = colors[0];

      for (int i = 0; i < numColors - 1; i++) {
        if (elapsedTime >= i * segment && elapsedTime < (i + 1) * segment) {
          currentColor = lerpColor(colors[i], colors[i + 1], (elapsedTime - i * segment) / segment);
          break;
        }
      }

      fill(currentColor);
      rect(barX, barY, progress - barX, barHeight);
      ellipse(progress, barY + barHeight / 2, 20, 20);

      if (elapsedTime >= 4) {
        gameEnded = true; // タイマーが終了
        questionAnswered[currentQuestion] = true;
        questionResults[currentQuestion] = false;
      }
    }
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
    float rowSpacing = height * 0.05;
    float centerX = width * 0.5;
    float leftColumnX = centerX - optionWidth - columnSpacing / 2;
    float rightColumnX = centerX + columnSpacing / 2;
    float firstRowY = height * 0.4;
    float secondRowY = height * 0.55;

    for (int i = 0; i < options[currentQuestion].length; i++) {
      float optionX = (i % 2 == 0) ? leftColumnX : rightColumnX;
      float optionY = (i < 2) ? firstRowY : secondRowY;

      if (mouseX > optionX && mouseX < optionX + optionWidth && mouseY > optionY && mouseY < optionY + optionHeight) {
       // effect2.play();
        clickedAnswer = i;
        gameEnded = true;
        questionAnswered[currentQuestion] = true;
        questionResults[currentQuestion] = (clickedAnswer == correctAnswers[currentQuestion]);
        if (questionResults[currentQuestion]) {
          ans++;
          println(ans);
        }else{
          //effect1.play();
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
