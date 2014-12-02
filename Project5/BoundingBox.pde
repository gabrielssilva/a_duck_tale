class BoundingBox {
  
  float x, dX;
  float y, dY;
  
  BoundingBox(float xo, float yo, float bbWidth, float bbHeight) {
    x = xo;
    y = yo;
    dX = bbWidth;
    dY = bbHeight;
  }
  
  void update(float xo, float yo) {
    x = xo;
    y = yo;
  }
  
  boolean isColliding(BoundingBox boundingBox) {
    if (x < boundingBox.x + boundingBox.dX &&
        x+dX > boundingBox.x &&
        y < boundingBox.y + boundingBox.dY &&
        y+dY > boundingBox.y) {
        
      return true;
    } else {
      return false;
    }
  }
}
