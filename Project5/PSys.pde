class PSys {

  ArrayList<Particle> particles;
  
  PSys(PVector source) {
    particles = new ArrayList();
    int numOfParticles = random(8, 12);
    
    for (int i=0; i<numOfParticles; i++) {
      PVector velocity = new PVector(random(-1, 1), random(-1, 1));
      particles.add(new Particle(source, velocity));
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

  PVector loc[], vel, accel;
  float r, life, initialLife, groundY;
  color pcolor;

  Particle(PVector start) {
    color particleColor = color(random(255), random(255), random(255));
    PVector vel = new PVector(random(-1, 1), random(-1, 1));
    
    genericConstructor(start, vel, particleColor);
    
    r = random(10, 15);
  }

  Particle(PVector start, PVector v, color particleColor, float radius) {
    genericConstructor(start, v, particleColor);
    
    groundY = random(height-200, height-50);
    r = random(radius-radius/3, radius);
  }

  void genericConstructor(PVector start, PVector v, color particleColor) {
    accel = new PVector(0, 0.05);
    vel = v;
    loc = new PVector[3];
    loc[0] = start.get();
    
    pcolor = particleColor;
    life = random(150, 180);
    initialLife = life;
    
    loc[1] = new PVector();
    loc[2] = new PVector();
  }

  void run() {
    updateP();
    renderP();
    updateP();
    renderP();
  }

  void updateP() {
    vel.add(accel); 
    loc[0].add(vel);
    life -= 1.0;
    
    loc[1].x = loc[0].x + 2*vel.x;
    loc[1].y = loc[0].y + 2*vel.y;
    loc[2].x = loc[1].x + 2*vel.x;
    loc[2].y = loc[1].y + 2*vel.y;
    
    if(loc[0].y > groundY) {
      pcolor = lerpColor(color(#F92200), color(#C01A00), random(0.5, 1));
    }
  }

  void renderP() {
    float alpha = map(life, 0, initialLife, 0, 100);
    float radius = map(life, 0, initialLife, r/3, r); 
    
    noStroke();
    fill(pcolor, alpha);
    for(int i=0; i<3; i++) {
      ellipse(loc[i].x, loc[i].y, radius, radius);
    }
  }

  // a function to test if a particle is alive
  boolean alive() {
    if (life <= 0.0) {
      return false;
    } else {
      return true;
    }
  }
}

