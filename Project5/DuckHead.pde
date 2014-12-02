class DuckHead {

  PImage sourceImgHead, sourceImgNeck;
  PVector position;
  float angle, size;
  boolean neckDown;
  BoundingBox boundingBox;

  DuckHead(float x, float y, float neckAngle, float duckSize) {
    position = new PVector(x, y);
    angle = neckAngle;
    size = duckSize;
    
    sourceImgHead = loadImage("data/duck/head.png");
    sourceImgNeck = loadImage("data/duck/neck.png");
    neckDown = true;

    // Those magic numbers are just adjusting the bounding box position! :D
    this.boundingBox = new BoundingBox(position.x, position.y, size*(sourceImgHead.width-60), size*(sourceImgHead.height-50));
  }

  void draw() {
    fill(245, 226, 12);
    
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    
    image(sourceImgNeck, 0, -sourceImgNeck.height/2);
    
    pushMatrix();
    translate(50, -40);
    rotate(-angle);
    
    image(sourceImgHead, 0, -sourceImgHead.height/2);
    popMatrix();
    
    popMatrix();
  }
  
  void update() {
    if (angle < -0.2) {
      neckDown = false;
    } else if (angle > 0.1) {
      neckDown = true;
    }
   
    if (neckDown) {
      angle -= .01; 
    } else {
      angle += .01;
    }
  }
  
  void updateBoundingBox(PVector duckPosition) {
    // Those magicnumbers are just adjusting the bounding box position! :D
    this.boundingBox.update(1.3*size*position.x, duckPosition.y-size*50);
  }
}
