abstract class Enemy {
  PImage sourceImg;
  PVector position, velocity;
  float size;
  boolean alive;
  BoundingBox boundingBox;

  Enemy(PVector enemyVel) {
    velocity = enemyVel.get();
    alive = true;
  }

  abstract void draw();

  void update() {
    position.add(velocity);

    alive = position.x > -sourceImg.width;
    boundingBox.update(position.x+size*8, position.y+size*5);
  }

  boolean isDead() {
    return !alive;
  }

  void generatePosition() {
    float x = width + sourceImg.width;
    float y = random(sourceImg.height, 0.6*height);

    position = new PVector(x, y);
  }
  
  void setBoundingBox(float size, PImage sourceImage) {
    boundingBox = new BoundingBox(position.x, position.y, size*(sourceImg.width-18), size*(sourceImg.height-8));
  }

  abstract void handleCollision(Level level);
}

// DarkCloud and IceFlake classes - - - - - - - - - - - - - - - - - - - - - - - -

class DarkCloud extends Enemy {
  Lightning lightning1, lightning2;
  
  DarkCloud(PVector enemyVel, float enemySize) {
    super(enemyVel);
    size = enemySize;
    
    int imageID = round(random(1, 2));
    sourceImg = loadImage("data/enemy/enemy"+imageID+".png");
    
    generatePosition();
    setBoundingBox(size, sourceImg);
    
    lightning1 = new Lightning(position.x+10, position.y+10, 1, true);
    lightning2 = new Lightning(position.x+70, position.y+10, 2, false);
  }
  
  void draw() {
    if (DEBUG_BOUNDING_BOXES) {
      noFill();
      stroke(0);
      rect(boundingBox.x, boundingBox.y, boundingBox.dX, boundingBox.dY);
    }    
    
    pushMatrix();
    scale(size);

    lightning1.draw(position.x+30, position.y+15);
    lightning2.draw(position.x+63, position.y+15);
    image(sourceImg, position.x, position.y);
    popMatrix();
    
    update();
  }
  
  void handleCollision(Level level) {
    level.killPlayer();
  }
}

class SnowFlake extends Enemy {
  float angle;
  
  SnowFlake(PVector enemyVel, float enemySize) {
    super(enemyVel);
    size = enemySize;
    angle = 0;
    
    sourceImg = loadImage("data/enemy/snow_flake.png");
    
    generatePosition();
    setBoundingBox(size, sourceImg);
  }
  
  void draw() {
    if (DEBUG_BOUNDING_BOXES) {
      noFill();
      stroke(0);
      rect(boundingBox.x, boundingBox.y, boundingBox.dX, boundingBox.dY);
    }    
    
    pushMatrix();
    translate(position.x+sourceImg.width/2, position.y+sourceImg.height/2);
    rotate(angle);
    scale(size);
    image(sourceImg, -sourceImg.width/2, -sourceImg.height/2);
    popMatrix();
    
    angle += PI/32;
    update();
  }
  
  void handleCollision(Level level) {
    level.freezesPlayer();
  }
}

