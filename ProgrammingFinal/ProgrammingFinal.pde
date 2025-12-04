Player player;
Enemy enemy;

void setup(){
  size(800, 800); //Sets the size of the screen to 800 by 800, to make details easier to see.
  
  //initialize the player
  player = new Player();
  
  enemy = new Enemy();
}

void draw(){
  noStroke();
  drawBackground(); //Draws the background using a function. 
  
  
  //Block of code dedicated to running the enemy methods
  enemy.draw();
  enemy.act();
  enemy.playerCheck(player);
  
  //Block of code dedicated to runnings the player methods
  player.act();
  player.draw();
  player.enemyCheck(enemy);
  
  drawHealthBars(player.health, enemy.health);
  
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

// Draws the health bars using map, and the int value of both the player and enemy health. 
void drawHealthBars(int p, int e){
    fill(0);
    println(e);
    rect(160, 0, 200, 40);
    rect(440, 0, 200, 40);
    fill(255);
    if (p > 0){
    beginShape();
      vertex(160 + map(p, 1000, 0, 0, 200), 0);
      vertex(160 + map(p, 1000, 0, 0, 200), 40);
      vertex(360, 40);
      vertex(360, 0);
      endShape(CLOSE);
    }
    
    if (e > 0){
      rect(440, 0, 200 - (map(e, 0, 1000, 200, 0)), 40);
    }
    
}
