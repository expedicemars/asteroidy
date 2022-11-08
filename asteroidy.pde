PImage rocket; //<>//
PShape shuttle;
PVector rpos;
ArrayList<Particle> particles;
short hazard_level = 0;
PImage logo;

float X_SHIFT = -300;
float SCALE_KOEF = 1;
float NEW_PER_SEC = 0.05; // cca 1 za 60 s, 0.017
float MINIMAP_RADIUS = 450;
float PERIMETER0 = 150; // velké nebezpečí
float PERIMETER1 = 300; // nízké nebezpečí

// perimetry
int pocet_perimetru = 6;
int rozestup = 75;
Perimetr[] ptest;
int pozadi = 0; //cerna
float inner_alpha = 70; //pruhlednost vnitrnich perimetru
float outer_alpha = 255; //pruhlednost posledniho perimetru, default zadna
int y_max = pocet_perimetru-1;
float aktualni_velikost;

// scanner
float scan_alpha = 0;
float scan_range_angle = 30 * PI/180;
color scan_color = color(255, 20, 0);

void drawASTEROIDY(){
  
  // náhodné přidávání částic
  if ( random(30) <= NEW_PER_SEC ) {
    // přidej částici na okraj minimapy
    float alpha = random(0, TWO_PI);
    PVector pos = new PVector( MINIMAP_RADIUS*cos(alpha), MINIMAP_RADIUS*sin(alpha) );

    float d_min = 200; // minimální vzdálenost průletu od rakety
    float d_max = 400; // maximální
    float dist = random(d_min, d_max);
    float beta = acos( dist/MINIMAP_RADIUS ) - alpha;
    PVector vel = new PVector( dist*cos(beta), dist*sin(beta) ).normalize().mult(-1); // nový vektor směrující doprostřed tak, aby netrefil loď)
    float mass = random(1, 2.5);

    Particle p = new Particle( pos, vel, mass, false);
    particles.add(p);
  }
  
  pushMatrix();
    translate(X_SHIFT,0);

  // částice
  for ( Particle p : particles) {
    //println(p.pos.mag());
    
    p.update();
    float dist_sq = p.pos.magSq();

    // když je za hranicí minimapy, smaž ho (stejně už se nevrátí) (+ rezerva)
    if ( dist_sq > MINIMAP_RADIUS*MINIMAP_RADIUS + 1 ) {
      particles.remove( p );
      break;
    }    

    // perimetry
    // nebezpečí
    if( dist_sq < 20*20 && p.real){
      // náraz (počítá se pouze od úmyslného nárazu za účelem alarmu)
      // start alarm
      // typ: p.type
      // časová délka: p.alarm_duration
      
      submitted = true;
    } else if ( dist_sq < PERIMETER0*PERIMETER0 && p.real ) {
      // vysoké nebezpečí      
      drawArrow(p, true, dist_sq);
      hazard_level = 2;
    } else if ( dist_sq < PERIMETER1*PERIMETER1 && p.real ) {
      // nízké nebezpečí      
      drawArrow(p, false, dist_sq);
      hazard_level = 1;
    } else {
      hazard_level = 0;
    }
    
    p.display();
  }

  drawRocket();
  drawMinimap();
  drawScanner();
  image(logo, width/2+600, height/2-420);
  color(255);
  textSize(100);
  text("RADAR", width/2 + 810, height/2+250);
  popMatrix();
  //drawHUD();
  //drawINFO();
  //println(hazard_level);

}

void setupASTEROIDY(){
  surface.setTitle("Minimapa");  
  logo = loadImage("logo.png");
  logo.resize( int(684*.6) , int(774*.6));
  particles = new ArrayList<Particle>(); 
  ptest = new Perimetr[pocet_perimetru];
  for (int y=0; y<pocet_perimetru; y++) {
    ptest[y] = new Perimetr();
  }
}

/*
void keyPressed(){
  // typ 1: odeberte se do vedlejšího modulu
  // typ 2: odeberte se do hlavního modulu
  if (key == 'a' || key == 'A') {
    // typ 1, 10 minut
    throwAlarmParticle(1, 10*60);
  }
  if (key == 's' || key == 'S') {
    // typ 2, 10 minut
    throwAlarmParticle(2, 10*60);
  } 
}*/

void drawScanner(){
   fill(scan_color, 100);
   arc(width/2, height/2, MINIMAP_RADIUS*2, MINIMAP_RADIUS*2, scan_alpha, scan_alpha + scan_range_angle);
   scan_alpha += .01;
}

void drawMinimap() {
    //vykreslení
  for (int y=0; y<pocet_perimetru-1; y++) {
    aktualni_velikost = rozestup*(y+1);
    ptest[y].display(aktualni_velikost*2, inner_alpha);
    ptest[y].subtitle(str(int(aktualni_velikost)), -aktualni_velikost -5, inner_alpha);
  }
  aktualni_velikost = pocet_perimetru * rozestup;
  ptest[y_max].display(aktualni_velikost*2, outer_alpha);
  ptest[y_max].cifernik(-aktualni_velikost +10);
}

void drawINFO(){
  pushMatrix();
    Particle p = particles.get(0);
    fill(0);
    textAlign(RIGHT);
    textSize(12);
    text("Vzdálenost meteoroidu: " + String.format("%.2f", p.pos.mag()*SCALE_KOEF) + " km", width - 20, 20);
    text("K. energie meteoroidu: " + String.format("%.2f", p.vel.magSq()*p.m*20) + " MJ", width - 20, 40);
  popMatrix();
}

void drawHUD() {
  pushMatrix();
  color col = 0;
    switch(hazard_level) {
    case 0:
      break;
    case 1:
      col = color(200, 150, 50);
      break;
    case 2: 
      col = color(255, 0, 0);
      break;
    }
      Particle p = particles.get(0);
    /*if ( /*col != 0*/ {  
      fill(col);
      textAlign(RIGHT);
      textSize(12);
      text("Vzdálenost meteoroidu: " + String.format("%.2f", p.pos.mag()*SCALE_KOEF) + " km", width - 20, 20);
      text("K. energie meteoroidu: " + String.format("%.2f", p.vel.magSq()*p.m*20) + " MJ", width - 20, 40);
    }
    

  popMatrix();
}

void drawRocket() {
  //draw simple rocket (sphere)
  pushMatrix();
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(2);
  noFill();
  line(8, 10, 0, -10);
  line(0, -10, -8, 10);
  
  strokeWeight(1);
  stroke(255, 100, 0);
  line(-3, 14, 0, 20);
  line(0, 20, 3, 14);
  popMatrix();
}

void drawArrow(Particle p, boolean severe, float dist_sq) {
  pushMatrix();
  translate(width/2, height/2);

  if (severe) {
    strokeWeight(2);
    stroke(255, 0, 0);
  } else {
    strokeWeight(1);
    stroke(200, 150, 50);
  }

  line( 0, 0, p.pos.x, p.pos.y );
  popMatrix();
}

void throwAlarmParticle(){
  float alpha = random(0, TWO_PI);
    PVector pos = new PVector( MINIMAP_RADIUS*cos(alpha), MINIMAP_RADIUS*sin(alpha) );

    float d_min = 75; // minimální vzdálenost průletu od rakety
    float d_max = 400; // maximální
    float dist = random(d_min, d_max);
    float beta = acos( dist/MINIMAP_RADIUS ) - alpha;
    PVector vel = new PVector( pos.x, pos.y).normalize().mult(-1); // nový vektor směrující doprostřed tak, aby netrefil loď)
    float mass = random(1, 2.5);

    Particle p = new Particle( pos, vel, mass, true);
    particles.add(p);
}