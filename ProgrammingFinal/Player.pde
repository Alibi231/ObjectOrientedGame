class Player {
  int health;
  String state; //States are neutral, block, dodge, attack, and down.
  String currentAction; // Actions: idle, punch, block, lDodge, rDodge, reel, stun
  PImage sprite;
  int counter;
  int knockdowns;
  int roundKnockdowns;
  PVector position;
  color c = color(100, 100, 100);

  Player() {
    health = 1000;
    state = "neutral";
    currentAction = "idle";
    //SET PImage
    counter = 0;
    knockdowns = 0;
    roundKnockdowns = 2;
    position = new PVector(320, 640);
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
        //Image = leftDodge;
        c = color(0, 255, 0);
      } else if (key == 'd') {
        counter = 30;
        currentAction = "rDodge";
        state = "dodge";
        //Image = rightDodge;
        c = color(0, 255, 0);
      } else if (key == 'w') {
        counter = 15;
        currentAction = "punch";
        state = "neutral";
        //Image = punch;
        c = color(100, 0, 0);
      } else if (key == 's') {
        c = color(0, 0, 255);
        //Image = block;
        state = "block";
        currentAction = "block";
      }
    }
  }

  void act() {
    if (counter > 0) {
      counter --;
    } else if (counter == 0) {
      //image = default
      if (currentAction != "block") {
        currentAction = "idle";
        state = "default";
        c = color(100, 100, 100);
      }
    }

    if (currentAction == "lDodge" || currentAction == "rDodge") {
      if (counter == 20) {
        //image = default
        c = color(100, 100, 100);
        state = "default";
      }
    } else if (currentAction == "punch") {
      if (counter == 5) {
        //PImage = punch
        c = color(255, 0, 0);
        state = "attack";
      } else if (counter == 4) {
        state = "neutral";
      }
    }
  }

  void draw() {
    //Will eventually use PImage, for now, use a grey rect
    fill(c);
    rect(position.x, position.y, 100, 200);
  }

  void blockCheck() {
    if (currentAction == "block") {
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
            c = color(200, 200, 200);
          } else {
            currentAction = "reel";
            state = "neutral";
            counter = 90;
            health -= enemy.pDamage;
            c = color(255, 255, 255);
          }
       }
     }
  }
  
  void stateReset(){
     state = "neutral";
     currentAction = "idle";
     counter = 0;
     //Sprite = Idle
     c = color(100);
     
  }
}
