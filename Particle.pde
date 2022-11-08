class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float m;
  boolean real; // typ poplachu (kam se mají odebrat)
  
  Particle(PVector pos_0, PVector vel_0, float m_0, boolean real_) {
    this.pos = pos_0;
    this.vel = vel_0;
    this.m = m_0;
    this.real = real_;
    
    this.acc = new PVector(0, 0, 0);
  }
  
  void update(){
    this.pos.add(this.vel);
    this.vel.add(this.acc);
    this.acc.mult(0);
  }
  
  void applyForce(PVector force){
    this.acc.add( force ).mult(1/this.m);
  }
  
  void display(){
    pushMatrix();
    noStroke();
    fill(255); 
    translate(width/2, height/2);
    ellipse(this.pos.x, this.pos.y, this.m*2, this.m*2);
    popMatrix();
  }
  
}