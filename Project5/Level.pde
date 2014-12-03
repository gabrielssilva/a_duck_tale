abstract class Level {

  PVector parallax1Vel, parallax2Vel, parallax3Vel, enemiesVel;
  ArrayList<Enemy> enemies;
  PSys sparks;
  LevelStatus status;

  color backgroundColor;
  float enemyCounter, maxEnemyCounter;
  float levelCounter, levelDuration;
  int frameRate;

  Parallax parallax;
  Duck duck;

  Level(Duck player, int gameFrameRate, String levelName) {
    duck = player;
    frameRate = gameFrameRate;
    enemies = new ArrayList();
    enemyCounter = 0;
    levelCounter = 0;

    setParallaxSettings();
    setEnemySettings();
    setLevelSettings();

    parallax = new Parallax(levelName, parallax1Vel, parallax2Vel, parallax3Vel);
    status = LevelStatus.BEGINNING;
  }

  void draw() {
    background(backgroundColor);
    parallax.draw();
    duck.draw();

    if (status == LevelStatus.BEGINNING) {
      beginLevel();
    } else if (status == LevelStatus.RUNNING) {
      doRunning();
    } else if (status == LevelStatus.ENDING) {
      endLevel();
    } else if (status == LevelStatus.GAME_OVER) {
      doGameOver();
    }
  }

  void beginLevel() {
    parallax.update();
    duck.update();

    if (duck.position.x > 30) {
      duck.setDirection(new PVector(0, 0));
      status = LevelStatus.RUNNING;
    }
  }

  void doRunning() {
    duck.update();
    parallax.update();
    drawEnemies();
    generateEnemies();

    enemyCounter += 1.0/FRAME_RATE;
    levelCounter += 1.0/FRAME_RATE;

    if (isLevelFinished() && enemies.isEmpty()) {
      status = LevelStatus.ENDING;
    } else {
      checkCollisions();
    }
  }

  void endLevel() {
    // Fade out
    duck.flyAway();
    duck.update();

    if (duck.position.x > width+120) {
      status = LevelStatus.WON;
      duck.reset(new PVector(-120, 250));
    }
  }

  void doGameOver() {
    duck.update();
    drawEnemies();
    parallax.update();

    sparks.run();
    
    if (enemies.isEmpty()) {
      status = LevelStatus.LOST;
    }
  }

  void updatePlayerDirection(PVector focusPoint) {
    if (status == LevelStatus.RUNNING) {
      duck.updateDirection(focusPoint);
    }
  }

  void drawEnemies() {
    for (int i= (enemies.size ()-1); i>=0; i--) {
      enemies.get(i).draw();

      if (enemies.get(i).isDead()) {
        enemies.remove(i);
      }
    }
  }

  void generateEnemies() {
    if (!isLevelFinished() && (enemyCounter > maxEnemyCounter)) {
      Enemy newEnemy = new Enemy(enemiesVel, 1);
      enemies.add(newEnemy);

      enemyCounter = 0;
    }
  }

  boolean isLevelFinished() {
    return levelCounter > levelDuration;
  }

  void checkCollisions() {
    for (Enemy enemy : enemies) {
      if (duck.isColliding(enemy)) {
        status = LevelStatus.GAME_OVER;

        PVector sparksPosition = new PVector(duck.position.x+100, duck.position.y);
        sparks = new PSys(sparksPosition);
        duck.die();
      }
    }
  }

  void begin() {
    duck.setDirection(new PVector(5, 0));
    status = LevelStatus.BEGINNING;
  }

  LevelStatus getStatus() {
    return status;
  }

  abstract void setParallaxSettings();
  abstract void setEnemySettings();
  abstract void setLevelSettings();
}

