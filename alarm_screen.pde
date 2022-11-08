
import processing.sound.*;
SoundFile file;
PImage bg;
PFont myFont;

int background = 0;
int blink = 2000; //millis
int tick = 1;

StopWatch stopky1 = new StopWatch(); int alarm_set_1[] = {0, 0, 30}; //h, m, s

/////////////////////////////
//__________ALARM__________//
/////////////////////////////

void setupALARM(){
  bg = loadImage("screen.jpg");
  bg.resize(width, height);
  file = new SoundFile(this, "danger.wav");
  myFont = loadFont("LetsgoDigital-Regular-48.vlw");
}

void drawALARM(){
  if (start_alarm){
    stopky1.alarm_start(alarm_set_1);
    start_alarm = false;
  }
  if (stopky1.is_running() && stopped == false){
    background(bg);
    draw_clock();
    blink();
  }else if(stopky1.is_finished() && stopped == false){ //(stopky1.is_finished() && stopped == false)
    background(bg);
    blink();
  }
}

void blink(){
    if (second()%3 == 0 && tick == 1){
    background(0);
    file.play();
    tick *= -1;
    }else{
    tick *= -1;
    }
}

void draw_clock(){
    textSize(80);
    textAlign(CENTER);
    fill(255,0,0);
    String str = stopky1.time_left() + "   ERROR " + error;
    //String str = "  ERROR " + error;
    //VARIANTA PRO 2 STOPKY: stopky1.is_finished() ? stopky2.time_left() : stopky1.time_left()
    textFont(myFont, height*0.12);
    text(str, width/2, height/2 *1.45); //*1.75
}

/////////////////////////////
//__________STOPKY__________//
/////////////////////////////

class StopWatch{
  int h = 1; int m = 1; int s = 1;
  int start_s, start_m, start_h;
  String s_str, m_str, h_str;
  boolean started = false;
  boolean finished = false;
  boolean running = false;
  int end_time = 0;
  
  StopWatch(){
  }
  
  void alarm_start(int[] alarm_set){
    started = true; finished = false;
    start_s = second() + alarm_set[2];
    start_m = minute()+ alarm_set[1];
    start_h = hour()+ alarm_set[0];
  }
  
  boolean is_finished(){
    end_time = millis();
    return finished;
  }
  
  boolean is_running(){
    running = started ? (!finished || !stopped ? true : false) : false;
    return running;
  }
  
  int end_time(){
    return end_time;
  }
  
  String time_left(){
    if ((s == 0)&&(m == 0)&&(h == 0)){
      finished = true;
     // h = 1; m = 1; s = 1;
    }else{
      if (s >= 0){
        s = start_s - second();
      }else{
        start_s += 60;
        s = start_s - second();
        start_m -= 1;
      }
      if (m >= 0){
        m = start_m - minute();
      }else{
        start_m += 60;
        m = start_m -  minute();
        start_h -= 1;
      }
      if (h >= 0){
        h = start_h - hour();
      }else{
        start_h += 24;
        h = start_h - hour();
      }
    }
    s_str = s < 10 ? "0" + str(s) : str(s); 
    m_str = m < 10 ? "0" + str(m) : str(m); 
    h_str = h < 10 ? "0" + str(h) : str(h); 
    return m_str + ":" + s_str;
  }
}