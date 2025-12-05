Player player;
Enemy enemy;
TimingMinigame timingMinigame;

String gameState;
int round = 1;
int timer = 180;
int frames;
int knockdownCounter;
int enemyGetup;
int playerGetup;

void setup() {
  noStroke();
  size(800, 800); //Sets the size of the screen to 800 by 800, to make details easier to see.
  round = 1;
  //initialize the player
  player = new Player();

  //initialize the enemy;
  enemy = new Enemy();

  timingMinigame = new TimingMinigame();

  //Starting the gamestate in intermission, to give the player a breather.
  gameState = "intermission";

  frameRate(60); // Sets framerate at 60 so animations can be standard.
  frames = 0;
}

void draw() {
  if (gameState == "play") {
    //This uses the frames variable to keep track of the amount of frames that have passed
    frames ++;
    if (frames % 20 == 0) { // This checks if the game is on a 20 frame interval, which due to frame rate, would be exactly 1/3rd of a second.
      timer --;
      if (timer == 0) { //Once the timer hits zero, the timer and framecount are reset, the round is increased, and the game goes to intermission
        frames = 0;
        timer  = 180;
        round ++;
        gameState = "intermission";
        player.stateReset();
        player.roundKnockdowns = 0;
        enemy.stateReset();
        enemy.roundKnockdowns = 0;
      }
    }




    drawRingBackground(); //Draws the background using a function.

    textCheat(str(timer), 720, 35, 50);


    //Block of code dedicated to running the enemy methods
    enemy.draw();
    enemy.act();
    enemy.playerCheck(player);
    if (enemy.state == "down") {
      frames = 0;
      knockdownCounter = 0;
      enemyGetup = int(random(1, 8)) + enemy.knockdowns;
      gameState = "enemyDown";
    }

    //Block of code dedicated to runnings the player methods
    player.act();
    player.draw();
    player.enemyCheck(enemy);
    if (player.state == "down") {
      knockdownCounter = 0;
      frames = 0;
      gameState = "playerDown";
      timingMinigame.resetMinigame(player.knockdowns);
    }



    drawHealthBars(player.health, enemy.health);

    if (!keyPressed) {

      //blockCheck is used here to stop the players block if they let go of the button
      player.blockCheck();
    }
  } else if (gameState == "intermission") {
    if (round <= 3){
        drawIntermissionBackground();
    } else {
      drawRingBackground();
      if(player.knockdowns >= enemy.knockdowns){
         textCheat("Judge Decision, You LOSE!", 15, 250, 70); 
      } else {
        textCheat("Judge Decision, You WIN!", 20, 250, 70); 
      }  
      
    }
    
  } else if (gameState == "enemyDown") {

    frames ++;

    if (frames % 60 == 0) {
      knockdownCounter ++;
      if (knockdownCounter == enemyGetup && knockdownCounter < 10) {
        enemy.stateReset();
        enemy.health = 1000 - (enemy.knockdowns * 100);
        gameState = "play";
        knockdownCounter = 0;
      }
    }



    drawRingBackground(); //Draws the background using a function.
    textCheat(str(timer), 720, 35, 50); //Adds the visual timer in the corner of the screen.


    player.act();
    player.draw();

    enemy.draw();

    drawHealthBars(player.health, enemy.health);

    // This block determines if the enemy has lost to a countout or to a TKO through a variety of if statements, and lets the player reset if they win.
    if (knockdownCounter >= 1) {
      if (enemy.roundKnockdowns < 3) {
        if (knockdownCounter >= 11) {
          textCheat("Knockout, You WIN!", 150, 250, 70);
          textCheat("Press Q to Restart!", 150, 350, 70);
          if (keyPressed) {
            if (key == 'q') {
              enemy.stateReset();
              enemy.health = 1000;
              enemy.knockdowns = 0;
              enemy.roundKnockdowns = 0;
              player.stateReset();
              player.health = 1000;
              player.knockdowns = 0;
              player.roundKnockdowns = 0;
              round = 1;
              gameState = "intermission";
              timer = 180;
            }
          }
        } else {
          textCheat(str(knockdownCounter), 380, 400, 100);
        }
      } else {
        textCheat("TKO, You WIN!", 225, 250, 70);
        textCheat("Press Q to Restart!", 225, 350, 70);
        if (keyPressed) {
          if (key == 'q') {
            enemy.stateReset();
            enemy.health = 1000;
            enemy.knockdowns = 0;
            enemy.roundKnockdowns = 0;
            player.stateReset();
            player.health = 1000;
            player.knockdowns = 0;
            player.roundKnockdowns = 0;
            round = 1;
            gameState = "intermission";
            timer = 180;
          }
        }
      }
    }
  } else if (gameState == "playerDown") {
    frames ++;

    drawRingBackground(); //Draws the background using a function.
    textCheat(str(timer), 720, 35, 50); //Adds the visual timer in the corner of the screen

    enemy.draw();

    drawHealthBars(player.health, enemy.health);

    if (frames % 60 == 0) {
      knockdownCounter ++;
    }

    timingMinigame.draw();
    timingMinigame.act();
    timingMinigame.play();

    if (timingMinigame.win == true) {
      enemy.stateReset();
      player.stateReset();
      player.health = 1000 - (player.knockdowns * 166);
      gameState = "play";
    }

    if (knockdownCounter >= 1) {
      if (player.roundKnockdowns < 3) {
        if (knockdownCounter >= 10) {
          textCheat("Knockout, You LOSE!", 150, 250, 70);
          textCheat("Press W to Restart!", 150, 350, 70);
          if (keyPressed) {
            if (key == 'w') {
              enemy.stateReset();
              enemy.health = 1000;
              enemy.knockdowns = 0;
              enemy.roundKnockdowns = 0;
              player.stateReset();
              player.health = 1000;
              player.knockdowns = 0;
              player.roundKnockdowns = 0;
              round = 1;
              gameState = "intermission";
              timer = 180;
            }
          }
        } else {
          textCheat(str(knockdownCounter), 380, 400, 100);
        }
      } else {
        textCheat("TKO, You LOSE!", 225, 250, 70);
        textCheat("Press Q to Restart!", 225, 350, 70);
        if (keyPressed) {
          if (key == 'q') {
            enemy.stateReset();
            enemy.health = 1000;
            enemy.knockdowns = 0;
            enemy.roundKnockdowns = 0;
            player.stateReset();
            player.health = 1000;
            player.knockdowns = 0;
            player.roundKnockdowns = 0;
            round = 1;
            gameState = "intermission";
            timer = 180;
          }
        }
      }
    }
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
  if (gameState == "play") {
    player.processInput();
  } else if (gameState == "intermission") {
    if (key == 'q') {
      gameState = "play";
    }
  }
}

// Draws the health bars using map, and the int value of both the player and enemy health.
void drawHealthBars(int p, int e) {
  fill(0);
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
void drawIntermissionBackground() {
  fill(0);
  rect(0, 0, 800, 800);
  fill(150);
  rect(0, 0, 300, 300);
  rect(500, 500, 300, 300);
  if (round == 1) {
    textCheat("Press W to Punch, \nPress A and D to Dodge,\nPress S to Block!", 300, 60, 50);
    textCheat("Dodge his punch, \nThen counter punch!\nPress Q to Start", 10, 560, 50);
  }
  textCheat("Round " + round, 225, 400, 100);
}

// This function lets me create as much text as I want, while technically only using the text function once in my code.
void textCheat(String txt, int xPos, int yPos, int txtSize) {
  fill(255);
  textSize(txtSize);
  text(txt, xPos, yPos);
}
