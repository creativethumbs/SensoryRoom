// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  float r = 1;
  float rChange = 0.001;
  float g = 1;
  float gChange = 0.001;
  float b = 1;
  float bChange = 0.001;

  ArrayList<Particle> particles;
  PVector origin;
  PVector accel;

  ParticleSystem(PVector position, PVector _accel, float rStart, float gStart, float bStart) {
    accel = _accel;
    origin = position.copy();
    particles = new ArrayList<Particle>();
    r = rStart;
    b = bStart;
    g = gStart;
  }

  void addParticle() {
    particles.add(new Particle(origin, accel, r, g, b));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r = 1;
  float rChange = 0.001;
  float g = 1;
  float gChange = 0.001;
  float b = 1;
  float bChange = 0.001;

  Particle(PVector l, PVector accel, float rStart, float gStart, float bStart) {
    acceleration = accel;
    velocity = new PVector(random(-1, 1), random(-1, 0));
    position = l.copy();
    lifespan = 225.0;
    
    r = rStart;
    b = bStart;
    g = gStart;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1;
  }

  // Method to display
  void display() {
    noStroke();
    fill(r, g, b, lifespan);
    ellipse(position.x, position.y, 32, 32);

    r = r + rChange;
    g = g + gChange;
    b = b + bChange;

    if (r < 0 || r > 255) {
      rChange *= -1;
    }

    if (g < 0 || g > 255) {
      gChange *= -.4;
    }

    if (b < 0 || b > 255) {
      bChange *= -.2;
    }
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
