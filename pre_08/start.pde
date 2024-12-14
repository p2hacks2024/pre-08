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
