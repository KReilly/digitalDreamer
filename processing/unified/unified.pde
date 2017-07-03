import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;
PGraphics offscreen;

Animations clock;
int numCalls = 0;

//Animations

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

void setup() {
  clock = new Animations("Clock Dial/AMMF_ClockDial_", 100, 12);



/*
PImage[] clockAnimation;   //Image files  => "Clock Dial/AMMF_ClockDial_00000.png" to "Clock Dial/AMMF_ClockDial_00360.png"
String baseFileNameAnimation = "Clock Dial/AMMF_ClockDial_";
int numFramesClock;
int playTimeClock; //change to time class and use milliseconds
int fpsClock; 
int currFrameClock;

void setup() {
  //Animation Variable Setup
  numFramesClock = 5;
  playTimeClock = 12;
  fpsClock = numFramesClock/playTimeClock;
  currFrameClock = 0;
  
  clockAnimation = new PImage[numFramesClock];
  String filename;
  for(int i=0; i<numFramesClock; i++){
    
    if(i<10){
      filename = baseFileNameAnimation + "0000" + i + ".png";
    }else if(i<100){
      filename = baseFileNameAnimation + "000" + i + ".png";
    }else{
      filename = baseFileNameAnimation + "00" + i + ".png";
    }
    
    println("Load File: " + filename);
    
    clockAnimation[i] = loadImage(filename);
  }
  
*/

  size(1920, 1080, P3D);

  //ks = new Keystone(this);
  //surface = ks.createCornerPinSurface(1920, 1080, 20);
  //offscreen = createGraphics(1920, 1080, P3D);
}

void draw() {

  // Convert the mouse coordinate into surface coordinates
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  //PVector surfaceMouse = surface.getTransformedMouse();

  // Draw the scene, offscreen
  
  
  //
  ///
  ////offscreen.beginDraw();
  background(0);
  //offscreen.background(255);
  //offscreen.fill(0, 255, 0);
  //offscreen.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
  
  //bg animation
    //check if movement from arduino is detected
    //adjust the currentFrame FPS
    //set the target frame
  
  if(clock.currentFrame >= clock.frames.length)
    clock.currentFrame = 0;
  //offscreen.image(clock.frames[clock.currentFrame], 0, 0); 
  image(clock.frames[clock.currentFrame], 0, 0); 
  clock.currentFrame++;



  
  
  //
  ///
  ////offscreen.endDraw();
  //background(0); //Fills all empty areas black
 
  // render the scene, transformed using the corner pin surface
  
  //
  ///
  ////surface.render(offscreen);
}



void keyPressed() {
  switch(key) {
    case 'c':
      // enter/leave calibration mode, where surfaces can be warped 
      // and moved 
      //ks.toggleCalibration();
      break;

    case 'l':
      // loads the saved layout
      //ks.load();
      break;

    case 's':
      // saves the layout
      //ks.save();
      break;


  }
}












//Todo: 
/*
    Make a calibration mode to adjust warping. 
      This then sets the plane adjustments or skews each image for projection
      Project grid
      Keys
        'C' for calibration mode to get the grid
        'X' for exit without saving changes
        'S' save adjustments and use for the duration of the run
        Select points to move using 1,2,3,4 and mouse keys to move them.
      
     Animations
       Load all of the images into an array for each animation.
       Play animations by moving images
       
     Arduino
       Integrate input from the touch points
       Integrate the clock
    
*/


/*
// Example 16-4: Display QuickTime movie

import processing.video.*;

// Step 1. Declare Movie object
Movie movie, touch1, touch2, touch3, touch4; 
int touch1Start = 0;
int swapFrame = 0;

void setup() {
  size(1920, 1080);

  // Step 2. Initialize Movie object
  // Movie file should be in data folder
  movie = new Movie(this, "ammf_colortest_0507.mp4"); 
  touch1 = new Movie(this, "ammf_trigger1.mov");
  touch2 = new Movie(this, "ammf_trigger2.mov");
  touch3 = new Movie(this, "ammf_trigger3.mov");
  touch4 = new Movie(this, "ammf_trigger4.mov");

  // Step 3. Start movie playing
  movie.loop();
  touch1.noLoop();
  touch2.noLoop();
  touch3.noLoop();
  touch4.noLoop();
}

// Step 4. Read new frames from movie
void movieEvent(Movie m) {
  m.read();
}

void draw() {
  // Step 5. Display movie.
  //image(movie, 0, 0);
  if (touch1Start ==1)
    if(swapFrame == 0){
      swapFrame = 1;
      image(touch1, 0, 0);
    }else{
      swapFrame = 0;
      image(touch2, 0, 0);
    }
  
  //image(movie, 0, 0);
}

void keyPressed() {
  if (key == '1') {
    touch1Start = 1;
    touch1.play();
  }
}
*/
