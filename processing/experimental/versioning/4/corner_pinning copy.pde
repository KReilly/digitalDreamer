import deadpixel.keystone.*;

//Corner Warping
Keystone ks;
CornerPinSurface surface;
PGraphics offscreen;

//Time
int currentTime, prevRead;



//Clock 
//Animation
PImage[] clockAnimation;   //Image files  => "Clock Dial/AMMF_ClockDial_00000.png" to "Clock Dial/AMMF_ClockDial_00360.png"
//PImage[] clockAnimation2;
String baseFileNameAnimation = "clock_dial720/clock_"; //"Clock Dial/AMMF_ClockDial_";
int numFramesClock, playTimeClock; //change to time class and use milliseconds
int fpsClock; 
int currFrameClock;
int lastUpdateTime;
//Arduino Info


//Touch Points
//Arduino Info
  //Input - Begin animation
  //Output - End LED glow
  
//Animation
/*
  PImage[] t1, t2, t3, t4;
  String t1FileName, t2FileName, t3FileName, t4FileName;
  int numFrameT1, numFrameT2, numFrameT3, numFrameT4;
  int playTimeT1, playTimeT2, playTimeT3, playTimeT4;
*/
//Animations t1, t2, t3, t4;


void setup() {  
  println("First Post");
 
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  //size(800, 600, P3D);
  size(1920, 1080, P3D);

  ks = new Keystone(this);
  //surface = ks.createCornerPinSurface(400, 300, 20);
  surface = ks.createCornerPinSurface(1920, 1080, 20);
  
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  //offscreen = createGraphics(400, 300, P3D);
  offscreen = createGraphics(1920, 1080, P3D);
  
  println("Begin Setup");
  
  currentTime = 0; 
  prevRead = 0;
  
  setupAnimations();

}

void draw() {

  // Convert the mouse coordinate into surface coordinates
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  PVector surfaceMouse = surface.getTransformedMouse();

  // Draw the scene, offscreen
  offscreen.beginDraw();
  //offscreen.background(255);  
  //offscreen.fill(0, 255, 0);
  //offscreen.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);

  currentTime = millis();


  //bg animation
  if(currentTime - lastUpdateTime > (1000/fpsClock)) {
      println("Updated Frame at time: " + currentTime);
      println("Delta is " + (currentTime - lastUpdateTime));  
      currFrameClock++;
      if(currFrameClock >= clockAnimation.length)
        currFrameClock = 0;
      lastUpdateTime = currentTime;   
    }  
    offscreen.image(clockAnimation[currFrameClock], 0, 0);
    //offscreen.image(clockAnimation2[currFrameClock], 0, 0);
      
  

  
  offscreen.endDraw();

  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
 
  // render the scene, transformed using the corner pin surface
  surface.render(offscreen);

  

}


void setupAnimations(){

  println("Setup Animations");
  //Animation Variable Setup
  numFramesClock = 360;//720;//361;
  playTimeClock = 12;//12;
  fpsClock = numFramesClock/playTimeClock;
  currFrameClock = 0;
  lastUpdateTime = 0;


  clockAnimation = new PImage[numFramesClock];
  //clockAnimation2 = new PImage[numFramesClock/2];
  String filename;
  //String filename2;
  for(int i=0; i<numFramesClock; i++){
    int indexed = i*2; 
    //int indexed2 = i*2+1;
    
    if(indexed<10){
      filename = baseFileNameAnimation + "0000" + indexed + ".png";
    }else if(indexed<100){
      filename = baseFileNameAnimation + "000" + indexed + ".png";
    }else{
      filename = baseFileNameAnimation + "00" + indexed + ".png";
    }
  /*  
    if(i< numFramesClock/2){
      if(indexed2<10){
        filename2 = baseFileNameAnimation + "0000" + indexed2 + ".png";
        }else if(indexed<100){
        filename2 = baseFileNameAnimation + "000" + indexed2 + ".png";
      }else{
        filename2 = baseFileNameAnimation + "00" + indexed2 + ".png";
      }
      clockAnimation2[i] = loadImage(filename2);
      println("Load File: " + filename2);
    }
    
    */
    println("Load File: " + filename);
    clockAnimation[i] = loadImage(filename);
    
    //clockAnimation2[i] = 
  }
  
  
  //Touch Animation Setup;
}

/*
class Animations{
  PImage[] frames;
  String baseFileName;
  int numFrames, duration, origFPS, currentFPS, currentFrame; //duration is in total number of seconds
  boolean isPlaying;
  
  Animations(String baseFileName, int numFrames, int duration){
      println("Loading Images One time");
      this.baseFileName = baseFileName;
      this.numFrames = numFrames;
      this.duration = duration;
      isPlaying = false;
      origFPS = duration/numFrames;
      currentFPS = origFPS;

      frames = new PImage[numFrames];
      for(int i = 0; i<frames.length; i++){
          String filename;
          if(i<10){
            filename = baseFileName + "0000" + i + ".png";
          }else if(i<100){
            filename = baseFileName + "000" + i + ".png";
          }else{
            filename = baseFileName + "00" + i + ".png";
          }
          
          //println("Load File: " + filename);
          
          frames[i] = loadImage(filename);
      }
  }
}



*/

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}
