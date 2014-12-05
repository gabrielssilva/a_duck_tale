final boolean DEBUG_BOUNDING_BOXES = false;
final int FRAME_RATE = 60;
final int NUM_OF_LEVELS = 3;
final float DELAY_TIME = 0.8;

PImage startButton, retryButton, backButton;

Level levels[];
EngineStatus status, lastValidStatus;
FadeStatus fadeStatus;
int activeLevel, fadeAlpha;
float currentTime;
PVector focusPoint;

void setup() {
  size(1200, 500);
  frameRate(FRAME_RATE);

  Duck duck = new Duck(-120, 250, 0.4, 2);
  focusPoint = new PVector(30, 250);

  levels = new Level[NUM_OF_LEVELS];
  levels[0] = new Level1(duck, FRAME_RATE);
  levels[1] = new Level2(duck, FRAME_RATE);
  levels[2] = new Level3(duck, FRAME_RATE);
  activeLevel = 0;

  currentTime = 0;
  fadeAlpha = 0;
  status = EngineStatus.ON_MENU;
  fadeStatus = FadeStatus.NONE;
  
  startButton = loadImage("data/start_button.png");
  retryButton = loadImage("data/play_again_button.png");
  backButton = loadImage("data/back_button.png");
}

void draw() {
  currentTime += 1.0/FRAME_RATE;

  if (status == EngineStatus.ON_MENU) {
    drawMenuScreen();
  } else if (status == EngineStatus.RUNNING) {
    runLevel();
  } else if (status == EngineStatus.ON_GAME_OVER) {
    drawGameOverScreen();
  } else if (status == EngineStatus.ENDING) {
    drawVictoryScreen();
  }

  delay();
  fade();
}

void runLevel() {
  noCursor();
  levels[activeLevel].draw();

  if (levels[activeLevel].getStatus() == LevelStatus.WON) {      
    nextLevel();
  } else if (levels[activeLevel].getStatus() == LevelStatus.LOST) {
    activateFade(EngineStatus.ON_GAME_OVER);
  }
}

void nextLevel() {
  activeLevel++;

  if (activeLevel < NUM_OF_LEVELS) {
    levels[activeLevel].begin();
    activateFade(EngineStatus.RUNNING);
  } else {
    activateFade(EngineStatus.ENDING);
  }
}

void drawMenuScreen() {
  cursor();
  
  drawSky(color(#53C7BB), "level3");
  drawGround("level1");
  
  PImage house = loadImage("data/locked_duck_house.png");
  PImage board = loadImage("data/board.png");
  
  image(house, 150, height-house.height);
  image(board, 0.62*width, -0.1*height);
  image(startButton, 0.65*width, 0.75*height);
}

void drawGameOverScreen() {
  textFont(loadFont("Helvetica.vlw"), 60);
  textAlign(CENTER, CENTER);
  
  drawSky(color(#3491A7), "level3");
  drawGround("level3");
  cursor();
  
  PImage deadDuck = loadImage("data/duck/dead_duck.png");
  image(deadDuck, 150, height-deadDuck.height);
  image(retryButton, 0.7*width, 0.6*height);
  
  textSize(90);
  fill(0);
  text("Fried duck... :(", 0.25*width, 0.1*height, 0.5*width, 0.2*height);
}

void drawVictoryScreen() {
  textFont(loadFont("Helvetica.vlw"), 60);
  textAlign(CENTER, CENTER);
  
  drawSky(color(#7ECDDF), "level1");
  drawGround("level1");
  cursor();
  
  PImage house = loadImage("data/duck_house.png");
  image(house, 150, height-house.height);
  image(backButton, 0.7*width, 0.6*height);
  
  textSize(90);
  fill(0);
  text("You did it, Home sweet home", 0, 0.1*height, width, 0.2*height);
}

void mouseMoved() {
  // Just change Y coordinate, keep the duck on the same X! 
  if (status == EngineStatus.RUNNING) {
    focusPoint.y = mouseY;
    levels[activeLevel].updatePlayerDirection(focusPoint);
  }
}

void mouseClicked() {
  if (status == EngineStatus.ON_MENU) {
    if (mouseX>0.65*width && mouseX<(0.65*width+startButton.width) 
        && mouseY>0.75*height && mouseY<(0.75*height+startButton.height)) {
      levels[activeLevel].begin();

      activateFade(EngineStatus.RUNNING);
    }
  } else if (status == EngineStatus.ON_GAME_OVER) {
    if (mouseX>0.7*width && mouseX<(0.7*width+retryButton.width) 
        && mouseY>0.6*height && mouseY<(0.6*height+retryButton.height)) {
      activeLevel= 0;
      levels[activeLevel].begin();

      activateFade(EngineStatus.RUNNING);
    }
  } else if (status == EngineStatus.ENDING) {
    if (mouseX>0.7*width && mouseX<(0.7*width+backButton.width) 
        && mouseY>0.6*height && mouseY<(0.6*height+backButton.height)) {
      activateFade(EngineStatus.ON_MENU);
    }
  }
}

void fade() {
  if (fadeStatus == FadeStatus.FADING_IN) {
    fadeIn();
  } else if (fadeStatus == FadeStatus.FADING_OUT) {
    fadeOut();
  }

  noStroke();
  fill(255, 255, 255, fadeAlpha);
  rect(0, 0, width, height);
}

void fadeIn() {
  if (fadeAlpha < 255) {
    fadeAlpha += 5;
  } else {
    fadeStatus = FadeStatus.FADING_OUT;
  }
}

void fadeOut() {
  if (fadeAlpha > 0) {
    fadeAlpha += -5;
  } else {
    fadeStatus = FadeStatus.NONE;
  }
}

void delay() {
  if ((status == EngineStatus.DELAYING) && (currentTime>DELAY_TIME)) {
    status = lastValidStatus;
  }
}

void activateFade(EngineStatus nextStatus) {
  fadeStatus = FadeStatus.FADING_IN;
  status = EngineStatus.DELAYING;
  lastValidStatus = nextStatus;

  currentTime = 0;
}

void drawSky(color bgColor, String level) {
  background(bgColor);
  PImage cloud1 = loadImage("data/"+level+"/parallax1/cloud1.png");
  PImage cloud2 = loadImage("data/"+level+"/parallax1/cloud2.png");
  PImage cloud3 = loadImage("data/"+level+"/parallax1/cloud3.png");
  
  image(cloud1, 200, 50);
  image(cloud2, 450, 120);
  image(cloud3, 80, 200);
  image(cloud1, 600, 200);
  image(cloud3, 900, 50);
  image(cloud2, 1100, 200);
}

void drawGround(String level) {
  PImage field1 = loadImage("data/"+level+"/parallax3/field1.png");
  PImage field2 = loadImage("data/"+level+"/parallax3/field2.png");
  
  image(field1, 0, height-field1.height);
  image(field2, field1.width, height-field2.height);
}
