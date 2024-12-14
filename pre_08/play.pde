void drawGameScreen() {
  background(0); // 背景は黒
  int currentTime = millis();

  if (state == 1) {
    // 最初の1秒間「第〇問」を表示
    if (currentTime - startTime < 1000) {
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
    if (currentTime - startTime < 750) {
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
      float elapsedTime = (millis() - startTime) / 1500.0; // 経過時間を秒に変換
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
