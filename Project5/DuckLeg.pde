class DuckLeg {
  
  PImage sourceImgPart1, sourceImgPart2;
  PVector position;
  float size, angle1, angle2;
  boolean leg1Down, leg2Down;
  BoundingBox boundingBox;

  DuckLeg(float x, float y, float legSize, float legAngle) {
    position = new PVector(x, y);
    size = legSize;
    angle1 = legAngle;
    angle2 = 0.3;
    
    sourceImgPart1 = loadImage("data/duck/leg_part1.png");
    sourceImgPart2 = loadImage("data/duck/leg_part2.png");
    leg1Down = false;
    leg2Down = false;
  }

  void draw() {
    fill(#FF8300);
    pushMatrix();
    scale(size);
    translate(position.x, position.y);
    rotate(angle1);

    pushMatrix();
    translate(-100, 20);
    rotate(angle2);
    image(sourceImgPart2, -sourceImgPart2.width, 0);
    popMatrix();
    
    image(sourceImgPart1, -sourceImgPart1.width, -sourceImgPart1.height/2);
    popMatrix();
  }

  void update() {
    if (angle1 < 0) {
      leg1Down = true;
    } else if (angle1 > 0.5) {
      leg1Down = false;
    }

    if (leg1Down) {
      angle1 += .03;
    } else {
      angle1 -= .03;
    }

    if (angle2 < 0) {
      leg2Down = true;
    } else if (angle2 > 0.5) {
      leg2Down = false;
    }

    if (leg2Down) {
      angle2 += .05;
    } else {
      angle2 -= .05;
    }
  }
}

