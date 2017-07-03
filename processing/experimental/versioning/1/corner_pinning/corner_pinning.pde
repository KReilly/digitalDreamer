/**
 * This is a simple example of how to use the Keystone library.
 *
 * To use this example in the real world, you need a projector
 * and a surface you want to project your Processing sketch onto.
 *
 * Simply drag the corners of the CornerPinSurface so that they
 * match the physical surface's corners. The result will be an
 * undistorted projection, regardless of projector position or 
 * orientation.
 *
 * You can also create more than one Surface object, and project
 * onto multiple flat surfaces using a single projector.
 *
 * This extra flexbility can comes at the sacrifice of more or 
 * less pixel resolution, depending on your projector and how
 * many surfaces you want to map. 
 */

import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;

PGraphics offscreen;

PImage[] clockAnimation;   //Image files  => "Clock Dial/AMMF_ClockDial_00000.png" to "Clock Dial/AMMF_ClockDial_00360.png"
String baseFileNameAnimation = "clock_dial720/clock_"; //"Clock Dial/AMMF_ClockDial_";
int numFramesClock;
int playTimeClock; //change to time class and use milliseconds
int fpsClock; 
int currFrameClock;

void setup() {
  //Animation Variable Setup
  numFramesClock = 360;//720;//361;
  playTimeClock = 24;//12;
  fpsClock = numFramesClock/playTimeClock;
  currFrameClock = 0;
  
  clockAnimation = new PImage[numFramesClock];
  String filename;
  for(int i=0; i<numFramesClock; i++){
    int indexed = i*2; 
    if(indexed<10){
      filename = baseFileNameAnimation + "0000" + indexed + ".png";
    }else if(indexed<100){
      filename = baseFileNameAnimation + "000" + indexed + ".png";
    }else{
      filename = baseFileNameAnimation + "00" + indexed + ".png";
    }
    println("Load File: " + filename);
    clockAnimation[i] = loadImage(filename);
  }
  




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
  
  //bg animation
  if(currFrameClock >= clockAnimation.length)
    currFrameClock = 0;
  offscreen.image(clockAnimation[currFrameClock], 0, 0);
  currFrameClock++;
  
  offscreen.endDraw();

  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
 
  // render the scene, transformed using the corner pin surface
  surface.render(offscreen);

  

}



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
