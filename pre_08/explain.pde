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
  text("このゲームは反射神経、観察力をためすゲームです。\n制限時間内に出題された問題の正しい答えを選んでください。\n出題される問題は全部で10問です。\n", width/2, height/2 + 60);

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
