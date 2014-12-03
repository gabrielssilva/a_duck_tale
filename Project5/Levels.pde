class Level1 extends Level {
  
  Level1(Duck duck, int gameFrameRate) {
    super(duck, gameFrameRate, "level1");
  }
  
  void setEnemySettings() {
    enemiesVel = new PVector(-6, 0);
    maxEnemyCounter = 1.5;
  }
  
  void setParallaxSettings() {
    parallax1Vel = new PVector(-2, 0);
    parallax2Vel = new PVector(-4, 0);
    parallax3Vel = new PVector(-6, 0);
  }
  
  void setLevelSettings() {
    backgroundColor = color(#7ECDDF);
    levelDuration = 10;
  }
}

// Level 2 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

class Level2 extends Level {
  
  Level2(Duck duck, int gameFrameRate) {
    super(duck, gameFrameRate, "level1");
  }
  
  void setEnemySettings() {
    enemiesVel = new PVector(-8, 0);
    maxEnemyCounter = 1;
  }
  
  void setParallaxSettings() {
    parallax1Vel = new PVector(-2, 0);
    parallax2Vel = new PVector(-4, 0);
    parallax3Vel = new PVector(-6, 0);
  }
  
  void setLevelSettings() {
    backgroundColor = color(#7ECDDF);
    levelDuration = 10;
  }
}


