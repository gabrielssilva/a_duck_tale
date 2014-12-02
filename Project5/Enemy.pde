class Enemy {

  PImage sourceImg;
  private PVector position, velocity;
  float size;
  boolean alive;
  BoundingBox boundingBox;
  Lightning lightning1, lightning2;

  Enemy(PVector enemyVel, float enemySize) {
    velocity = enemyVel.get();
    size = enemySize;
    
    int imageID = round(random(1, 2));
    sourceImg = loadImage("data/enemy/enemy"+imageID+".png");

    generatePosition();
    alive = true;

    // X and Y are changed on update! 
    boundingBox = new BoundingBox(position.x, position.y, size*(sourceImg.width-18), size*(sourceImg.height-8));
    lightning1 = new Lightning(position.x+10, position.y+10, 1, true);
    lightning2 = new Lightning(position.x+70, position.y+10, 2, false);
  }

  void draw() {
    if(DEBUG_BOUNDING_BOXES) {
      noFill();
      stroke(0);
      rect(boundingBox.x, boundingBox.y, boundingBox.dX, boundingBox.dY);
    }

    scale(size);

    lightning1.draw(position.x+30, position.y+15);
    lightning2.draw(position.x+63, position.y+15);
    image(sourceImg, position.x, position.y);
    
    update();
  }

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

  float getX() {
    return position.x;
  }

  float getY() {
    return position.y;
  }

  float getWidth() {
    return sourceImg.width;
  }

  float getHeight() {
    return sourceImg.height;
  }
  
  void generateLightnings() {
    
  }
}

