abstract class PSys {
  
  PVector position, pRangeX, pRangeY;
  ArrayList<Particle> particles;
  float particleDelay, counter;
  
  PSys(PVector source, float initialParticles, float interval, String name) {
    position = source.get();
    particles = new ArrayList();
    
    counter = 0;
    particleDelay = interval;
    
    for (int i=0; i<initialParticles; i++) {
      addParticle(particles, source, name);
    }
  }

  void run() {
    for (int i=particles.size()-1; i>=0; i--) {
      Particle p = particles.get(i);
      p.run();
      
      if (!p.alive()) {
        particles.remove(i);
      }    
    }
    
    update();
  }
  
  void update() {
    if (counter > particleDelay) {
      updateSys(particles, position);
      counter = 0;
    } else {
      counter += 1.0/frameRate;
    }
  }

  boolean isDead() {
    return particles.isEmpty();
  }
  
  abstract void addParticle(ArrayList<Particle> particle, PVector sysPosition, String name);
  abstract void updateSys(ArrayList<Particle> particle, PVector sysPosition);
}

// Spark and Envieroment PSys - - - - - - - - - - - - - - - - - - - - - - - - - -

class SparkPsys extends PSys {
  SparkPsys(PVector source, String pName) {
    super(source, random(15, 20), 0, pName);
  }
  
  void addParticle(ArrayList<Particle> particles, PVector sysPosition, String name) {
    particles.add(new SparkParticle(sysPosition, name));
  }
  
  void updateSys(ArrayList<Particle> particles, PVector sysPosition) {
    // Do nothing
  }
}

class Enviroment extends PSys {
  
  String particleName;
  
  Enviroment(String pName, float interval) {
    super(new PVector(width/2, 0), 0, interval, pName);
    particleName = pName;
  }
  
  void addParticle(ArrayList<Particle> particles, PVector sysPosition, String name) {
    PVector particle1Position = new PVector(random(0, width/2), -0.1*width);
    PVector particle2Position = new PVector(random(width/2, 1.2*width), -0.1*width);
    
    particles.add(new EnviromentParticle(particle1Position, name));
    particles.add(new EnviromentParticle(particle2Position, name));
  }
  
  void updateSys(ArrayList<Particle> particles, PVector sysPosition) {
    addParticle(particles, sysPosition, particleName);
  }
}


// Particle Class - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

abstract class Particle {

  PImage sourceImg;
  PVector position, direction, acceleration;
  float maxSize, life, angle, initialLife;

  Particle(PVector startPosition, String imageName, float pLife, float pSize) {
    position = startPosition.get();
    sourceImg = loadImage("data/"+imageName+".png");
    
    direction = setDirection();
    acceleration = setAcceleration();
    
    life = pLife;
    initialLife = life;
    maxSize = pSize;
    angle = 0;
  }

  void run() {
    update();
    draw();
  }

  void update() {
    direction.add(acceleration);
    angle = setAngle(direction, position);
    position.add(direction); 
    life -= 1.0;
  }

  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    
    float size = map(life, 0, initialLife, 0, maxSize);
    scale(size);
    
    image(sourceImg, 0, 0);
    popMatrix();
  }

  boolean alive() {
    return life > 0.0;
  }
  
  abstract PVector setDirection();
  abstract PVector setAcceleration();
  abstract float setAngle(PVector position, PVector direction);
}

// Specific particles to Sparks and Enviroments - - - - - - - - - - - - - - - - - - - - -

class SparkParticle extends Particle {
  SparkParticle(PVector position, String name) {
    super(position, name, random(40, 60), random(0.3, 1));
  }
  
  PVector setDirection() {
    return new PVector(random(-1, 1), random(-1, 1));
  }
  
  PVector setAcceleration() {
    return new PVector(0.05, 0.01);
  }
  
  float setAngle(PVector position, PVector direction) {
    return PVector.angleBetween(direction, position);
  }
}

class EnviromentParticle extends Particle {
  EnviromentParticle(PVector position, String particleName) {
    super(position, particleName, random(400, 600), random(0.3, 1));
  }
  
  PVector setDirection() {
    return new PVector(0, 0.5);
  }
  
  PVector setAcceleration() {
    return new PVector(-0.1, 0.2);
  }
  
  float setAngle(PVector position, PVector direction) {
    return 90;
  }
}
