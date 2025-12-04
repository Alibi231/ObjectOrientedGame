void setup(){
  size(800, 800); //Sets the size of the screen to 800 by 800, to make details easier to see. 
}

void draw(){
  noStroke();
  drawBackground(); //Draws the background using a function. 
}

// This function draws the ring using a variety of rects
void drawBackground(){
  fill(25, 90, 0);
  rect(0, 440, 1000, 1000);
  rect(0, 160, 40, 1000);
  rect(760, 160, 40, 1000);
  fill(20, 20, 160);
  rect(40, 200, 720, 40);
  rect(40, 280, 720, 40);
  rect(40, 360, 720, 40);
  
}
