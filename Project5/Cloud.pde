class Cloud extends ParallaxComponent{
  
  Cloud(String cloudName, PVector pVelocity, float offset) {
    super(cloudName, pVelocity, offset);
  }
  
  void update() {
    position.add(velocity);
    
    if (position.x < -sourceImg.width) {
      generatePosition(0.0);
    }
  }
  
  void generatePosition(float offset) {
    float x = width + offset;
    float y = random(0, 0.5*height);
    
    position = new PVector(x, y);
  }
}
