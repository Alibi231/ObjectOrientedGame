Player player;

void setup(){
  size(800, 800); //Sets the size of the screen to 800 by 800, to make details easier to see.
  
  //initialize the player
  player = new Player();
}

void draw(){
  noStroke();
  drawBackground(); //Draws the background using a function. 
  
  //Block of code dedicated to runnings the player methods
  player.act();
  player.draw();
  
  if (!keyPressed){
    //blockCheck is used here to stop the players block if they let go of the button
    player.blockCheck();
  }
  
  frameRate(60); // Sets framerate at 60 so animations can be standard. 
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

void keyPressed(){
   player.processInput(); 
}
