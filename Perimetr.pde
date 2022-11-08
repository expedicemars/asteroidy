class Perimetr{
  float xpos;
  float ypos;
  float velikost;
  color barva;
  PFont f_titulek, f_cifernik;
  
  Perimetr(){
    xpos = width/2;
    ypos = height/2;
    barva= color(202, 66, 0);
    f_titulek = createFont("Arial",16,true); 
    f_cifernik = createFont("Arial",12,true);
  }
  
  void display(float velikost, float alpha){
    strokeWeight(1);
    stroke(barva, alpha);
    noFill();
    ellipse(xpos, ypos, velikost, velikost);
  }
  
  void subtitle(String titulek, float offset, float alpha){
    textFont(f_titulek, 12);                  // STEP 3 Specify font to be used
    fill(barva, alpha);                         // STEP 4 Specify font color 
    textAlign(CENTER);
    text(titulek, xpos, ypos + offset);
  }
  
  void cifernik(float offset){
    int delka = 7;
    int delsi_delka = 12;
    int frevence_delsich_car = 15;
    int pocet_car = 90;
    int num_text = 0;
    for (int y=0; y<pocet_car; y++){
       float usek = y * (TWO_PI/pocet_car);
       float amplituda = offset;
       float tmp_ypos = (ypos) + sin(usek) * amplituda;
       float tmp_xpos = (xpos) + cos(usek) * amplituda;
       float prodlouzeni = (y % frevence_delsich_car) == 0 ? delsi_delka : delka;
       float tmp_ypos_2 = (ypos) + sin(usek) * (amplituda + prodlouzeni);
       float tmp_xpos_2 = (xpos) + cos(usek) * (amplituda + prodlouzeni);
       stroke(barva);
       line(tmp_xpos, tmp_ypos, tmp_xpos_2, tmp_ypos_2);

       if(prodlouzeni > delka){
           textFont(f_titulek,12);                  // STEP 3 Specify font to be used
           fill(barva, 255);                         // STEP 4 Specify font color 
           //textAlign(CENTER);
           String num = str(int(num_text*(360/(pocet_car/frevence_delsich_car))));
           prodlouzeni = delsi_delka + 15;
           float tmp_ypos_3 = (ypos) + sin(usek) * (amplituda + prodlouzeni) + 12/2;
           float tmp_xpos_3 = (xpos) + cos(usek) * (amplituda + prodlouzeni);
           text(num, tmp_xpos_3, tmp_ypos_3);
           num_text += 1;
       }
    }
  }
}