void drawBulb(float x, float y, float width, float height) {
  if (bulbImage == null) {
    println("電球画像がロードされていません。描画をスキップします。");
    return;
  }
  imageMode(CENTER); // 中心基準で描画
  image(bulbImage, x, y, width, height); // 指定サイズで描画
}
PImage removeWhiteBackground(PImage img) {
  PImage result = createImage(img.width, img.height, ARGB);
  img.loadPixels();
  result.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    if (brightness(c) > 95) {
      result.pixels[i] = color(0, 0, 0, 0); // 透明にする
    } else {
      result.pixels[i] = c;
    }
  }
  result.updatePixels();
  return result;
}
void drawStartScreen() {
  // 電球で囲む
  drawBulbRing(width / 2, height / 2, 150, 10);

  // スタートボタン
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
    drawBulb(bx, by, 50, 50);
  }
}
boolean isMouseOverStartButton() {
  return dist(mouseX, mouseY, width / 2, height / 2) < 100;
}
void mousePressed() {
  if (gmn == 0 && isMouseOverStartButton()) {
    gmn = 1;
  }
}
