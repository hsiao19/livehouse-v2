// MODE "TEST" FOR KEYBOARD TESTING.
// MODE "PERFORMANCE" FOR PERFORMANCE.
String MODE = "TEST";
int screenWidth = 1024;
int screenHeight = 500;

/* --- signal setting ----------------------------------------- */
import processing.serial.*;
int end = 10;
String serial;
Serial port;
boolean connectSerial = false;
/* ------------------------------------------------------------ */

Handler handler;

void setup() {
  size(1024, 525, P3D);
  //fullScreen(P3D); new Handler();
  
  handler = new Handler(); 
  if(MODE == "PERFORMANCE"){
    connectSerial(); 
  }  
}

void draw() {
  background(0);
  if(MODE == "PERFORMANCE"){
    readSignal();
    handler.update(serial);  
  }
  pushMatrix();
  handler.display();
  popMatrix();
  //saveFrame();
}

void connectSerial() {
  try {
    port = new Serial(this, "com4", 9600);
    port.clear();

    serial = port.readStringUntil(end);
    connectSerial = true;
  }  
  catch(Exception e) {
    connectSerial = false;
    println("Failed to connect com4.");
  }
}

void readSignal() {
  if (connectSerial) {
    while (port.available () > 0) {
      serial = port.readStringUntil(end);
      //println("serial " + serial);
    }
  }
  else{
    println("Connection faild");
  }
}
