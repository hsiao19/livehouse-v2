class MeshScene extends AbsScene {
  ArrayList particles = new ArrayList();
  boolean addParticle;

  MeshScene() {
    fill(0, 150, 255, 5);
    background(20);
  }

  void addNewLocate(float x, float y) {
    float _x = x * relPixel;
    float _y = y * relPixel;
    particles.add(new Particle(new PVector(_x, _y)));
  }

  void update() {
    if (addParticle) {
      Particle p = (Particle) particles.get((int)random(particles.size()));
      particles.add(new Particle(p.loc));
    }
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle) particles.get(i);
      p.draw();
      p.move();
    }
  }

  class Particle {
    PVector loc, vel;

    float angle;

    Particle(PVector l) {
      loc = l.get();
      float r = random(0, 1);
      if (r < 2) {
        angle = 0;
      } else if (r > 2 && r < 4) {
        angle = 90;
      } else if (r > 4 && r < 6) {
        angle = 180;
      } else if (r > 6 && r < 8) {
        angle = 270;
      } else {
        angle = 360;
      }
      vel = new PVector(sin(radians(angle)), cos(radians(angle)));
    }

    void draw() {
      ellipse(loc.x, loc.y, 3, 3);
    }

    void move() {
      loc.add(vel);
      vel.mult(0.95);
      if (vel.mag() < 0.1) {
        changeVel();
        addParticle = true;
      } else {
        addParticle = false;
      }
    }

    void changeVel() {
      float r = random(0, 1);
      float newAngle = angle;
      if (r > 0.5) {
        newAngle+=90;
      } else {
        newAngle-=90;
      }
      vel = new PVector(sin(radians(newAngle)), cos(radians(newAngle)));
      angle = newAngle;
    }
  }
}