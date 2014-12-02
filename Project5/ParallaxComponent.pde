class ParallaxComponent {

  PImage sourceImg;
  PVector position, velocity, offset;
  
  ParallaxComponent(String componentName, PVector pVelocity, float offset) {
    velocity = pVelocity.get();
    sourceImg = loadImage("data/"+componentName+".png");    
    
    position = new PVector(offset, random(0, 0.5*height));
  }
  
  ParallaxComponent(String componentName, PVector pVel, int sequence) {
    sourceImg = loadImage("data/"+componentName+".png");
    position = new PVector(sequence*sourceImg.width, height-sourceImg.height);
    velocity = pVel.get();
  }

  void draw() {
    image(sourceImg, position.x, position.y); 
  }

  void update(int numberOfComponents) {
    position.add(velocity);

    if (position.x < -sourceImg.width) {
      generatePosition(numberOfComponents);
    }
  }
  
  void generatePosition(int numberOfComponents) {
    position.x += (numberOfComponents)*sourceImg.width - 5;
  }
}

