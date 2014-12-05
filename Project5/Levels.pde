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

  Enviroment setEnviroment() {
    return null;
  } 

  void addEnemies(ArrayList<Enemy> enemies) {
    enemies.add(new DarkCloud(enemiesVel, 1));
  }
}

// Level 2 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

class Level2 extends Level {

  int enemiesAdded;

  Level2(Duck duck, int gameFrameRate) {
    super(duck, gameFrameRate, "level2");
    enemiesAdded = 0;
  }

  void setEnemySettings() {
    enemiesVel = new PVector(-8, 0);
    maxEnemyCounter = 0.8;
  }

  void setParallaxSettings() {
    parallax1Vel = new PVector(-2, 0);
    parallax2Vel = new PVector(-4, 0);
    parallax3Vel = new PVector(-6, 0);
  }

  void setLevelSettings() {
    backgroundColor = color(#3491A7);
    levelDuration = 10;
  }

  Enviroment setEnviroment() {
    return new Enviroment("level2/snow_flake", 0.1);
  }

  void addEnemies(ArrayList<Enemy> enemies) {
    if (enemiesAdded%2 == 0) {
      enemies.add(new SnowFlake(enemiesVel, 1));
    } else {
      enemies.add(new DarkCloud(enemiesVel, 1));
    }
    
    enemiesAdded++;
  }
}

// Level 3 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class Level3 extends Level {

  Level3(Duck duck, int gameFrameRate) {
    super(duck, gameFrameRate, "level3");
  }

  void setEnemySettings() {
    enemiesVel = new PVector(-8, 0);
    maxEnemyCounter = 3;
  }

  void setParallaxSettings() {
    parallax1Vel = new PVector(-2, 0);
    parallax2Vel = new PVector(-4, 0);
    parallax3Vel = new PVector(-6, 0);
  }

  void setLevelSettings() {
    backgroundColor = color(#53C7BB);
    levelDuration = 10;
  }

  Enviroment setEnviroment() {
    return new Enviroment("level3/rain_drop", 0.01);
  }

  void addEnemies(ArrayList<Enemy> enemies) {
    enemies.add(new Tornado(enemiesVel, 1));
  }
}


