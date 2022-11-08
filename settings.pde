import controlP5.*;
ControlP5 cp5;

String url1, url2, url3, url4;
boolean submitted = false;
boolean stopped = true;
int error;
int[] time_array = {0, 0, 0};

class PWindow extends PApplet {
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(300, 250);
  }

  void setup() {
    background(0);
    setNASTAVENI();
    drawNADPIS_NASTAVENI();
  }

  void draw() {
  }
  
  void drawNADPIS_NASTAVENI(){
    textSize(40);
    textAlign(CENTER);
    fill(100);
    text("ASTEROIDY", width/2, height/2*1.7);
  }
 
  void Submit() {
    // odkomentovat pro zobrazení alarm screenu
    //submitted = true;
    print("the following text was submitted :");
    url1 = cp5.get(Textfield.class,"HH").getText();
    url2 = cp5.get(Textfield.class,"MM").getText();
    url3 = cp5.get(Textfield.class,"SS").getText();
    url4 = cp5.get(Textfield.class,"ERROR").getText();
    time_array[0] = int(url1);
    time_array[1] = int(url2);
    time_array[2] = int(url3);
    error = int(url4);
    
    throwAlarmParticle();
    
    println();
  }
  
  void Stop(){
    stopped = true;
  }
  
  void setNASTAVENI(){
    int size = 40;
    int init_x = 20; int init_y = 20;
    PFont font = createFont("arial", 20);
    textFont(font);
    cp5 = new ControlP5(this);
    cp5.addTextfield("HH")
      .setPosition(init_x, init_y)
          .setSize(size, size)
              .setAutoClear(false)
                  .setFocus(true)
                      .setFont(font);
    cp5.addTextfield("MM")
      .setPosition(init_x * 3, init_y)
          .setSize(size, size)
              .setAutoClear(false)
                  .setFocus(true)
                      .setFont(font);
    cp5.addTextfield("SS")
      .setPosition(init_x * 5, init_y)
          .setSize(size, size)
              .setAutoClear(false)
                  .setFocus(true)
                      .setFont(font);
    cp5.addTextfield("ERROR")
      .setPosition(init_x * 9, init_y)
          .setSize(size, size)
              .setAutoClear(false)
                  .setFocus(true)
                      .setFont(font);
    cp5.addBang("Submit")
      .setPosition(init_x, init_y * 5)
          .setSize(80, 40)
              .setFont(font); 
    cp5.addBang("Stop")
      .setPosition(init_x * 9, init_y * 5)
          .setSize(80, 40)
              .setFont(font); 
  }
}