class Player {
  int health;
  String state; //States are neutral, block, dodge, attack, and down.
  String currentAction; // Actions: idle, punch, block, lDodge, rDodge, reel, stun
  PImage sprite;
  int counter;
  int knockdowns;
  int roundKnockdowns;
  PVector position;


  Player() {
    health = 1000;
    state = "neutral";
    currentAction = "idle";
    sprite = loadImage("playerIdle.png");
    counter = 0;
    knockdowns = 0;
    roundKnockdowns = 0;
    position = new PVector(320, 600);
  }


  /*
    This function is run when keypressed is triggered in the main scene, so it only
   reads for inputs when a key has been pressed down.
   */
  void processInput() {
    /*
    While in previous projects I went through a rather complicated process to
     ensure that multiple inputs could be recognized at once, in this game you should
     need only a single input registered at a time, so I went with the basic method
     for reading inputs.
     */
    if (currentAction == "idle") {
      if (key == 'a') {
        counter = 40;
        currentAction = "lDodge";
        state = "dodge";
        sprite = loadImage("playerLDodge.png");
      } else if (key == 'd') {
        counter = 40;
        currentAction = "rDodge";
        state = "dodge";
        sprite = loadImage("playerRDodge.png");
      } else if (key == 'w') {
        counter = 15;
        currentAction = "punch";
        state = "neutral";
        sprite = loadImage("playerWindup.png");
      } else if (key == 's') {
        sprite = loadImage("playerBlock.png");
        state = "block";
        currentAction = "block";
      }
    }
  }

  void act() {
    if (counter > 0) {
      counter --;
    } else if (counter == 0) {
      if (currentAction != "block") {
        sprite = loadImage("playerIdle.png");
        currentAction = "idle";
        state = "default";
      }
    }

    if (currentAction == "lDodge" || currentAction == "rDodge") {
      if (counter == 20) {
        sprite = loadImage("playerIdle.png");
        state = "default";
      }
    } else if (currentAction == "punch") {
      if (counter == 5) {
        sprite = loadImage("playerPunch.png");
        state = "attack";
      } else if (counter == 4) {
        state = "neutral";
      }
    }
  }

  void draw() {
    //Will eventually use PImage, for now, use a grey rect
    image(sprite, position.x, position.y);
  }

  void blockCheck() {
    if (currentAction == "block") {
      sprite = loadImage("playerIdle.png");
      currentAction = "neutral";
    }
  }
  
  void enemyCheck(Enemy enemy){
     if (enemy.state == "attack"){
       if (state != "dodge"){
          if (state == "block" && enemy.pDamage != 800){
            currentAction = "stun";
            state = "neutral";
            counter = 80;
            health -= int (enemy.pDamage / 4);
          } else {
            currentAction = "reel";
            state = "neutral";
            sprite = loadImage("playerReel.png");
            counter = 90;
            health -= enemy.pDamage;
          }
       }
     }
     
     if (health <= 0) {
      knockdowns ++;
      roundKnockdowns ++;
      state = "down";
      currentAction = "idle";
      counter = 0;
    }
  }
  
  void stateReset(){
     state = "neutral";
     currentAction = "idle";
     counter = 0;
     sprite = loadImage("playerIdle.png");   
  }
}
