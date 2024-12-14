void Fireworks() { 
  
  // ランダムに花火を追加
  if (random(1) < 0.1) {
    HashMap<String, Object> firework = new HashMap<String, Object>();
    PVector position = new PVector(random(width), height - 700);
    PVector velocity = new PVector(0, random(-10, -5));
    PVector acceleration = new PVector(0, 0);
    color c = color(random(255), random(255), random(255));
    firework.put("position", position);
    firework.put("velocity", velocity);
    firework.put("acceleration", acceleration);
    firework.put("exploded", false);
    firework.put("color", c);
    firework.put("lifespan", 255.0);
    firework.put("particles", new ArrayList<HashMap<String, Object>>());
    firework.put("size", random(10, 50));
    fireworks.add(firework);
  }
  
  // 花火の描画と更新
  for (int i = fireworks.size() - 1; i >= 0; i--) {
    HashMap<String, Object> firework = fireworks.get(i);
    PVector position = (PVector) firework.get("position");
    PVector velocity = (PVector) firework.get("velocity");
    PVector acceleration = (PVector) firework.get("acceleration");
    boolean exploded = (boolean) firework.get("exploded");
    ArrayList<HashMap<String, Object>> particles = (ArrayList<HashMap<String, Object>>) firework.get("particles");
    color c = (color) firework.get("color");
    
    // 爆発していない場合、更新
    if (!exploded) {
      acceleration.add(new PVector(0, 0.1)); // 重力
      velocity.add(acceleration);
      position.add(velocity);
      acceleration.mult(0);
      if (velocity.y >= 0) { // 頂点に到達したら爆発
        firework.put("exploded", true);
        for (int j = 0; j < 100; j++) {
          HashMap<String, Object> particle = new HashMap<String, Object>();
          PVector pVelocity = PVector.random2D();
          pVelocity.mult(random(2, 10));
          particle.put("position", position.copy());
          particle.put("velocity", pVelocity);
          particle.put("acceleration", new PVector(0, 0));
          particle.put("color", c);
          particle.put("lifespan", 255.0);
          particles.add(particle);
        }
      }
    }
    
    // 爆発後の粒子を更新
    for (int j = particles.size() - 1; j >= 0; j--) {
      HashMap<String, Object> particle = particles.get(j);
      PVector pPosition = (PVector) particle.get("position");
      PVector pVelocity = (PVector) particle.get("velocity");
      PVector pAcceleration = (PVector) particle.get("acceleration");
      float lifespan = (float) particle.get("lifespan");
      
      pAcceleration.add(new PVector(0, 0.1)); // 重力
      pVelocity.add(pAcceleration);
      pPosition.add(pVelocity);
      pAcceleration.mult(0);
      lifespan -= 3;
      particle.put("lifespan", lifespan);
      if (lifespan < 0) {
        particles.remove(j);
      }
    }
    
    // 爆発後、すべての粒子が消えたらリストから削除
    if (exploded && particles.isEmpty()) {
      fireworks.remove(i);
    }
    
    // 花火の描画
    if (!exploded) {
      noStroke();
      fill(c);
      ellipse(position.x, position.y, 8, 8);
    }
    for (HashMap<String, Object> particle : particles) {
      PVector pPosition = (PVector) particle.get("position");
      color pColor = (color) particle.get("color");
      float lifespan = (float) particle.get("lifespan");
      noStroke();
      fill(pColor, lifespan);
      ellipse(pPosition.x, pPosition.y, 6, 6);
    }
  }
}
