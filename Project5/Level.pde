abstract class Level {
  PVector parallax1Vel, parallax2Vel, parallax3Vel, enemiesVel;
  ArrayList<Enemy> enemies;
  PSys sparks;
  
  color backgroundColor;
  float enemyCounter, maxEnemyCounter;
  float levelCounter, levelDuration;
  int frameRate;
  boolean playerActive, beginning, running, ending, gameOver, done;

  Parallax parallax;
  Duck duck;

  Level(Duck player, int gameFrameRate, String levelName) {
    duck = player;
    frameRate = gameFrameRate;
    enemies = new ArrayList();
    playerActive = false;
    enemyCounter = 0;
    levelCounter = 0;

    setParallaxSettings();
    setEnemySettings();
    setLevelSettings();

    parallax = new Parallax(levelName, parallax1Vel, parallax2Vel, parallax3Vel);
    beginning = false;
    running = false;
    ending = false;
    done = false;
    gameOver = false;
  }

  void draw() {
    background(backgroundColor);
    parallax.draw();
    duck.draw();

    if (beginning) {
      beginLevel();
    } else if (running) {
      drawLevel();
    } else if (ending) {
      endLevel();
    } else if (gameOver) {
      doGameOver();
    }
    
    if (sparks != null) {
      
    }
  }

  void beginLevel() {
    parallax.update();
    duck.update();

    if (duck.position.x > 30) {
      duck.setDirection(new PVector(0, 0));
      playerActive = true;
      beginning = false;
      running = true;
    }
  }

  void drawLevel() {
    duck.update();
    parallax.update();
    drawEnemies();
    generateEnemies();

    enemyCounter += 1.0/FRAME_RATE;
    levelCounter += 1.0/FRAME_RATE;

    if (isLevelFinished() && enemies.isEmpty()) {
      playerActive = false;
      running = false;
      ending = true;
    } else {
      checkCollisions();
    }
  }

  void endLevel() {
    // Fade out
    duck.flyAway();
    duck.update();

    if (duck.position.x > width+120) {
      ending = false;
      done = true;
      duck.reset(new PVector(-120, 250));
    }
  }
  
  void doGameOver() {
    duck.update();
    drawEnemies();
    parallax.update();
    
    sparks.run();
  }

  void updatePlayerDirection(PVector focusPoint) {
    if (isPlayerActive()) {
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
        playerActive = false;
        gameOver = true;
        running = false;
        
        PVector sparksPosition = new PVector(duck.position.x+100, duck.position.y);
        sparks = new PSys(sparksPosition);
        duck.die();
      }
    }
  }

  boolean isPlayerActive() {
    return playerActive;
  }

  void begin() {
    duck.setDirection(new PVector(5, 0));
    beginning = true;
  }

  boolean isDone() {
    return done;
  }

  abstract void setParallaxSettings();
  abstract void setEnemySettings();
  abstract void setLevelSettings();
}

