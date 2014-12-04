class Parallax {

  ArrayList<Cloud> clouds;
  ArrayList<ParallaxComponent> mountains;
  ArrayList<ParallaxComponent> fields;

  Parallax(String level, PVector parallax1Vel, PVector parallax2Vel, PVector parallax3Vel) {
    clouds = new ArrayList();
    mountains = new ArrayList();
    fields = new ArrayList();

    initClouds(level+"/parallax1/cloud", 3, parallax1Vel);
    initComponents(mountains, level+"/parallax2/mountain", 5, parallax2Vel);
    initComponents(fields, level+"/parallax3/field", 3, parallax3Vel);
  }

  void draw() {
    drawClouds();
    drawComponents(mountains);
    drawComponents(fields);
  }

  void update() {
    updateClouds();
    updateComponents(mountains);
    updateComponents(fields);
  }

  void initComponents(ArrayList<ParallaxComponent> components, String componentType, int numberOfComponents, PVector pVel) {
    for (int i=0; i<numberOfComponents; i++) {
      String componentName = componentType + (i+1);

      ParallaxComponent newComponent = new ParallaxComponent(componentName, pVel, i);
      components.add(newComponent);
    }
  }

  void initClouds(String cloudType, int numberOfClouds, PVector pVel) {
    float distance = 0;

    for (int i=0; i<numberOfClouds; i++) {
      String cloudName = cloudType + (i+1);
      distance += 400;

      Cloud newCloud = new Cloud(cloudName, pVel, distance);
      clouds.add(newCloud);
    }
  }

  void drawComponents(ArrayList<ParallaxComponent> components) {
    for (ParallaxComponent component : components) {
      component.draw();
    }
  }

  void drawClouds() {
    for (Cloud cloud : clouds) {
      cloud.draw();
    }
  }

  void updateComponents(ArrayList<ParallaxComponent> components) {
    int numberOfComponents = components.size();

    for (ParallaxComponent component : components) {
      component.update(numberOfComponents);
    }
  }

  void updateClouds() {
    for (Cloud cloud : clouds) {
      cloud.update();
    }
  }
}

// Parallax Componentn Class - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

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
    position.x += (numberOfComponents)*sourceImg.width - 10;
  }
}

