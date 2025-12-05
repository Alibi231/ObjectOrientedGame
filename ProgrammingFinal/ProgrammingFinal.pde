Player player;
Enemy enemy;
String gameState;
int round = 1;
int timer = 180;
int frames;

void setup() {
  size(800, 800); //Sets the size of the screen to 800 by 800, to make details easier to see.

  //initialize the player
  player = new Player();

  //initialize the enemy;
  enemy = new Enemy();

  //Starting the gamestate in intermission, to give the player a breather.
  gameState = "intermission";

  frameRate(60); // Sets framerate at 60 so animations can be standard.
  frames = 0;
}

void draw() {
  if (gameState == "play") {
    
    //This uses the frames variable to keep track of the amount of frames that have passed
    frames ++;
    if (frames % 20 == 0){ // This checks if the game is on a 20 frame interval, which due to frame rate, would be exactly 1/3rd of a second.
       timer --; 
       if (timer == 0){ //Once the timer hits zero, the timer and framecount are reset, the round is increased, and the game goes to intermission
          frames = 0;
          timer  = 180;
          round ++;
          gameState = "intermission";
          player.stateReset();
          enemy.stateReset();
       }
    }
    
    
    
    noStroke();
    drawRingBackground(); //Draws the background using a function.
    
    textCheat(str(timer), 720, 35, 50);


    //Block of code dedicated to running the enemy methods
    enemy.draw();
    enemy.act();
    enemy.playerCheck(player);

    //Block of code dedicated to runnings the player methods
    player.act();
    player.draw();
    player.enemyCheck(enemy);

    drawHealthBars(player.health, enemy.health);

    if (!keyPressed) {

      //blockCheck is used here to stop the players block if they let go of the button
      player.blockCheck();
    }
  } else if (gameState == "intermission"){
    drawIntermissionBackground();
  }
}

// This function draws the ring using a variety of rects, for the gameState "play".
void drawRingBackground() {
  fill(100);
  rect(0, 0, 800, 800);
  fill(25, 90, 0);
  rect(0, 440, 1000, 1000);
  rect(0, 160, 40, 1000);
  rect(760, 160, 40, 1000);
  fill(20, 20, 160);
  rect(40, 200, 720, 40);
  rect(40, 280, 720, 40);
  rect(40, 360, 720, 40);
}

void keyPressed() {
  if (gameState == "play"){
  player.processInput();
  } else if (gameState == "intermission"){
     if(key == 'w'){
        gameState = "play"; 
     }
  }
}

// Draws the health bars using map, and the int value of both the player and enemy health.
void drawHealthBars(int p, int e) {
  fill(0);
  println(e);
  rect(160, 0, 200, 40);
  rect(440, 0, 200, 40);
  fill(255);
  if (p > 0) {
    beginShape();
    vertex(160 + map(p, 1000, 0, 0, 200), 0);
    vertex(160 + map(p, 1000, 0, 0, 200), 40);
    vertex(360, 40);
    vertex(360, 0);
    endShape(CLOSE);
  }

  if (e > 0) {
    rect(440, 0, 200 - (map(e, 0, 1000, 200, 0)), 40);
  }
}

//Draws a in between rounds image in the vein of Punchout!
void drawIntermissionBackground(){
  fill(0);
  rect(0, 0, 800, 800);
  fill(150);
  rect(0, 0, 300, 300);
  rect(500, 500, 300, 300);
  if (round == 1){
    textCheat("Press W to Punch, \nPress A and D to Dodge,\nPress S to Block!", 300, 60, 50);
    textCheat("Dodge his punch, \nThen counter punch!\nPress W to Start", 10, 560, 50);
  }
  textCheat("Round " + round, 225, 400, 100);
}

// This function lets me create as much text as I want, while technically only using the text function once in my code. 
void textCheat(String txt, int xPos, int yPos, int txtSize){
  fill(255);
  textSize(txtSize);
  text(txt, xPos, yPos);
}
