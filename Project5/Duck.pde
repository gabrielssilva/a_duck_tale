class Duck {

  PImage sourceImg;
  PVector position, direction;
  float size, initSpeed, speed, rotation;
  boolean dead, frozen;
  BoundingBox boundingBox;

  DuckLeg frontLeg, backLeg;
  DuckWing frontWing, backWing;
  DuckHead head;

  Duck(float x, float y, float duckSize, float duckSpeed) {
    size = duckSize;
    initSpeed = speed = duckSpeed;
    rotation = 0;
    frozen = dead = false;

    sourceImg = loadImage("data/duck/body.png");
    position = new PVector(x-size*sourceImg.width/1.25, y-size*sourceImg.height/2);
    direction = new PVector(0, 0);
    initDuck();

    // The following crazy numbers just adjust the size of the bounding box! :D
    boundingBox = new BoundingBox(position.x, position.y, size*(sourceImg.width-62.5), size*(sourceImg.height-62.5));
  }

  void initDuck() {
    head = new DuckHead(300, 35, 0, size);

    frontLeg = new DuckLeg(190, 140, 1, 0);
    backLeg = new DuckLeg(240, 190, 0.6, 0);

    frontWing = new DuckWing(310, 15, 1, 0);
    backWing = new DuckWing(530, 15, 0.6, 0.2);
  }

  void draw() {
    if (DEBUG_BOUNDING_BOXES) {
      noFill();
      stroke(0);
      rect(boundingBox.x, boundingBox.y, boundingBox.dX, boundingBox.dY);
      rect(head.boundingBox.x, head.boundingBox.y, head.boundingBox.dX, head.boundingBox.dY);
    }

    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    scale(size);

    backWing.draw();
    backLeg.draw();
    head.draw();

    image(sourceImg, 0, 0);

    frontLeg.draw();
    frontWing.draw();
    popMatrix();
  }

  void update() {
    position.add(direction);

    updateParts();
    // Those magicnumbers are just adjusting the bounding box position! :D
    boundingBox.update(size*50+position.x, size*50+position.y);
    head.updateBoundingBox(position);
    
    if(dead) {
      rotation += 0.03;
    }
    
    if (speed < initSpeed) {
      speed += 0.01;
    } else {
      frozen = false;
    }
  }

  void updateParts() {
    head.update();

    frontLeg.update();
    backLeg.update();

    frontWing.update();
    backWing.update();
  }

  void updateDirection(PVector focusPoint) {
    direction = focusPoint.get();
    direction.sub(position);

    if (direction.mag() > speed) {
      direction.setMag(speed);
    }
  }
  
  void setDirection(PVector newDirection) {
    direction = newDirection.get();
  }

  boolean isColliding(Enemy enemy) {
    boolean isBodyColliding = boundingBox.isColliding(enemy.boundingBox); 
    boolean isHeadColliding = head.boundingBox.isColliding(enemy.boundingBox);

    return isBodyColliding || isHeadColliding;
  }
  
  void die() {
    setDirection(new PVector(2*speed, 3*speed));
    dead = true;
  }
  
  void freeze() {
    if(!frozen) {
      frozen = true;
      speed = 0;
    }
  }
  
  void flyAway() {
    if(!dead) {
      setDirection(new PVector(4*speed, 0));
    }
  }
  
  void reset(PVector newPosition) {
    this.rotation = 0;
    this.dead = false;
    
    this.position = newPosition.get();
    this.direction = new PVector(0, 0);
  }
}

