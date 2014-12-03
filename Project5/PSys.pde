class PSys {

  ArrayList<Particle> particles;
  
  PSys(PVector source) {
    particles = new ArrayList();
    float numOfParticles = random(15, 20);
    
    for (int i=0; i<numOfParticles; i++) {
      particles.add(new Particle(source));
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
  }

  boolean isDead() {
    return particles.isEmpty();
  }
}


// Particle Class - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

class Particle {

  PImage sourceImg;
  PVector start, position, direction, acceleration;
  float maxSize, life, angle, initialLife;

  Particle(PVector startPosition) {
    start = startPosition.get();
    position = startPosition.get();
    sourceImg = loadImage("data/spark.png");
    direction = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0.05, 0.01);
    
    life = random(30, 60);
    initialLife = life;
    maxSize = random(0.3, 1);
  }

  void run() {
    update();
    draw();
  }

  void update() {
    direction.add(acceleration);
    angle = PVector.angleBetween(direction, position);
    position.add(direction); 
    life -= 1.0;
    
    
  }

  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(-angle);
    
    float size = map(life, 0, initialLife, 0, maxSize);
    scale(size);
    
    
    image(sourceImg, 0, 0);
    popMatrix();
  }

  boolean alive() {
    return life > 0.0;
  }
}

