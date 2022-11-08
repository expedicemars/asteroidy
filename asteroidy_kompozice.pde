PWindow win;

boolean start_alarm = false;

public void settings() {
  size(1920, 1080);
}

void setup() {
  win = new PWindow();
  setupALARM();
  setupASTEROIDY();
}

void draw() {
  frameRate(30);
  //if (){ //stopky1.is_running() || !stopped
     background(0);
     drawALARM();
 // }else{
   if (!stopky1.is_running() || stopped){
     background(0);
     drawASTEROIDY();
   }
   //println(submitted);
  //}
  if(submitted){
    alarm_set_1[0] = time_array[0];
    alarm_set_1[1] = time_array[1];
    alarm_set_1[2] = time_array[2];
    start_alarm = true;
    stopped = false;
    submitted = false;
  }
}