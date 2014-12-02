class Lightning {
  
  PImage sourceImg;
  PVector position, direction;
  float initialY;
  
  Lightning(float x, float y, int imageID, boolean last) {
    position = new PVector(x, y);
    sourceImg = loadImage("data/enemy/lightning"+imageID+".png");
      
    direction = new PVector(0, 0.5);
    initialY = position.y;
    
    if(last) {
      position.y += sourceImg.height-5;
    }
  }
  
  void draw(float x, float y) {
    position.x = x;
    image(sourceImg, position.x, position.y);
    update();
  }
  
  void update() {
    position.add(direction);
    
    if((position.y > (initialY+sourceImg.height-5)) || (position.y < initialY)) {
      direction.y = -direction.y;
    }
  }
}
