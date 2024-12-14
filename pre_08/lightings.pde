void Lightnings() {
  // ランダムに雷を生成
  if (random(1) < 0.1) {
    HashMap<String, Object> lightning = new HashMap<String, Object>();
    ArrayList<PVector> points = new ArrayList<PVector>();
    points.add(new PVector(random(width), 0)); // 雷の起点を設定
    lightning.put("points", points);
    lightning.put("done", false);
    lightnings.add(lightning);
  }

  // 雷の描画と更新
  for (int i = lightnings.size() - 1; i >= 0; i--) {
    HashMap<String, Object> lightning = lightnings.get(i);
    ArrayList<PVector> points = (ArrayList<PVector>) lightning.get("points");
    boolean done = (boolean) lightning.get("done");

    // 更新
    if (!done) {
      PVector last = points.get(points.size() - 1);
      float xOffset = random(-30, 30); // 横幅の調整
      float yOffset = random(20, 100); // 速度の調整
      PVector next = new PVector(last.x + xOffset, last.y + yOffset);
      points.add(next);

      // 雷が画面の下に到達したかどうかをチェック
      if (next.y >= height) {
        lightning.put("done", true);
      }
    }

    // 描画
    stroke(255, 255, 0);
    strokeWeight(2);
    noFill();
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape();

    // 消えた雷をリストから削除
    if (done) {
      lightnings.remove(i);
    }
  }
}
