// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

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

