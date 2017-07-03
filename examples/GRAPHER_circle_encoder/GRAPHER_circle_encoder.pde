import processing.serial.*;
Serial myPort;        // The serial port
int colla=0, omy = 2, colla2= 215, colla3 = 255, omy2=2, omy3 = 2;//all do the color stuff
float cosx, siny;
void setup () {
  // set the window size:
  size(1500, 900);        

  // List all the available serial ports
  println(Serial.list());// look in the window when the program runs to see which port to use
  myPort = new Serial(this, Serial.list()[0], 115200);  // for me com 26 was port 0, so I put a 0 here
  
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
}
void draw () {
  // everything happens in the serialEvent()
}

void serialEvent (Serial myPort) {// triggers when new data comes in
background(0);
  String pulses_raw = myPort.readStringUntil('\n'); //read until the new line, like print ln
  
  if (pulses_raw != null) {
    // trim off any whitespace:
    pulses_raw = trim(pulses_raw);
    // convert to an int and map to the screen height:
    float pulses = float(pulses_raw); 


    // mapping input data to height of screen
    //inByte = map(inByte,0, 96, 0, 360);
    
    pulses = pulses*3.141592654/48;
    
    siny= sin(pulses);
    cosx= cos(pulses); 
    
    stroke(colla,colla2,colla3);
    strokeWeight(10);
    fill(colla,colla2,colla3);

    line(width/2, height/2, width/2+width/2*cosx, height/2+ height/2*siny);

     
      colla = colla +omy;
      if (colla >254)
      omy = omy * -1;
      if (colla <1)
      omy = omy * -1;  
      
      colla2 = colla2 +omy2;
      if (colla2 >254)
      omy2 = omy2 * -1;
      if (colla2 <1)
      omy2 = omy2 * -1;  
      
      colla3 = colla3 +omy3;
      if (colla3 >254)
      omy3 = omy3 * -1;
      if (colla3 <1)
      omy3 = omy3 * -1;  

 
 
  }
}


