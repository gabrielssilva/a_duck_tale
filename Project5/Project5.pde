final boolean DEBUG_BOUNDING_BOXES = false;
final int FRAME_RATE = 60;
final int NUM_OF_LEVELS = 2;
final float DELAY_TIME = 0.8;

Level levels[];
int activeLevel, fadeAlpha;
float currentTime;
PVector focusPoint;
boolean fadingIn, fadingOut, menu, running, delaying;

void setup() {
  size(1200, 500);
  frameRate(FRAME_RATE);

  Duck duck = new Duck(-120, 250, 0.4, 2);
  focusPoint = new PVector(30, 250);

  levels = new Level[NUM_OF_LEVELS];
  levels[0] = new Level1(duck, FRAME_RATE);
  levels[1] = new Level2(duck, FRAME_RATE);
  activeLevel = 0;

  currentTime = 0;
  fadeAlpha = 0;

  menu = true;
  fadingIn = false;
  fadingOut = false;
  running = false;
  delaying = false;
}

void draw() {
  currentTime += 1.0/FRAME_RATE;

  if (menu && !delaying) {
    drawMenu();
  } else if (activeLevel < NUM_OF_LEVELS && !delaying) {
    levels[activeLevel].draw();

    if (levels[activeLevel].isDone()) {      
      activeLevel++;
      nextLevel();
    }
  }

  delay();
  fade();
}

void fade() {
  if (fadingIn) {
    fadeIn();
  } else if (fadingOut) {
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
    fadingIn = false;
    fadingOut = true;
  }
}

void fadeOut() {
  if (fadeAlpha > 0) {
    fadeAlpha += -5;
  } else {
    fadingOut = false;
  }
}

void delay() {
  if (delaying && (currentTime>DELAY_TIME)) {
    delaying = false;
  }
}

void nextLevel() {
  if (activeLevel < NUM_OF_LEVELS) {
    levels[activeLevel].begin();

    activateFade();
  } else {
    running = false;
  }
}

void drawMenu() {
  background(0);
  cursor();

  fill(255);
  rect(0.65*width, 0.3*height, 0.3*width, 0.2*height);
  //rect(0.65*width, 0.6*height, 0.3*width, 0.2*height);

  fill(0);
  textFont(loadFont("Helvetica.vlw"), 60);
  textAlign(CENTER, CENTER);
  text("Play", 0.65*width, 0.3*height, 0.3*width, 0.18*height);
}

void mouseMoved() {
  // Just change Y coordinate, keep the duck on the same X! 
  if (running) {
    focusPoint.y = mouseY;
    levels[activeLevel].updatePlayerDirection(focusPoint);
  }
}

void mouseClicked() {
  if (menu) {
    if (mouseX>0.65*width && mouseX<0.95*width && mouseY>0.3*height && mouseY<0.48*height) {
      menu = false;
      running = true;
      levels[activeLevel].begin();

      activateFade();
    }
  }
}

void activateFade() {
  fadingIn = true;
  delaying = true;
  currentTime = 0;
}

