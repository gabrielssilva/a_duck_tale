class DuckWing {

  PImage sourceImgPart1, sourceImgPart2;
  PVector position;
  float size, angle;
  boolean wingDown;
  BoundingBox boundingBox;

  DuckWing(float x, float y, float wingSize, float wingAngle) {
    position = new PVector(x, y);
    size = wingSize;
    angle = wingAngle;

    sourceImgPart1 = loadImage("data/duck/wing_part1.png");
    sourceImgPart2 = loadImage("data/duck/wing_part2.png");
    wingDown = false;
  }

  void draw() {
    fill(227, 208, 66);
    pushMatrix();
    scale(size);
    translate(position.x, position.y);
    
    rotate(angle);
    image(sourceImgPart1, -sourceImgPart1.width, -sourceImgPart1.height/2);

    pushMatrix();
    translate(-120, -10);
    rotate(angle);
    image(sourceImgPart2, -sourceImgPart1.width, -sourceImgPart1.height/2);
    popMatrix();
    popMatrix();
  }

  void update() {

    if (angle < -0.5) {
      wingDown = true;
    } else if (angle > 0.3) {
      wingDown = false;
    }

    if (wingDown) {
      angle += .1;
    } else {
      angle -= .1;
    }
  }
}
