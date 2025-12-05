class Enemy {
  int health;
  String state; //States are vulnerable, open, block, dodge, attack, invulnerable, and down
  String currentAction; // Actions: idle, jab, hook, uppercut, block, reel
  PImage sprite;
  int waitTime; // How much the enemy will wait before their next action.
  int reelTime; //If the enemy is hit right now, how long will they be stunned for?
  int pDamage; //How much damage the current punch will do if it connects
  int counter;
  int knockdowns;
  int roundKnockdowns;
  int randomizer;
  PVector position;
  color c = color(0, 0, 0);

  Enemy() {
    health = 1000;
    state = "block";
    currentAction = "idle";
    //SET PImage
    waitTime = 144;
    reelTime = 0;
    pDamage = 0;
    counter  = 0;
    knockdowns = 0;
    roundKnockdowns = 0;
    randomizer = int(random(11));
    position = new PVector(360, 400);
  }

  void draw() {
    //Will eventually use PImage, for now, use a grey rect
    fill(c);
    rect(position.x, position.y, 100, 200);
  }

  void act() {
    if (waitTime > 0 && currentAction == "idle") {
      waitTime --;
    } else if (waitTime <= 0 && currentAction == "idle") {
      if (randomizer <= 5) {
        state = "invulnerable";
        currentAction = "jab";
        reelTime = 105;
        pDamage = 100;
        counter = 110;
        //Sprite = jabStart
        c = color(100, 0, 0);
      } else if (randomizer <= 8) {
        state = "invulnerable";
        currentAction = "hook";
        reelTime = 200;
        pDamage = 300;
        counter = 150;
        //Sprite = hookStartStart
        c = color(0, 100, 0);
      } else {
        state = "invulnerable";
        currentAction = "uppercut";
        reelTime = 300;
        pDamage = 800;
        counter = 150;
        //Sprite = upperCutStart
        c = color(0, 0, 100);
      }
    }  else if (waitTime <= 0 && currentAction == "block") {
      if (randomizer <= 5) {
        state = "invulnerable";
        currentAction = "jab";
        reelTime = 105;
        pDamage = 100;
        counter = 110;
        //Sprite = jabStart
        c = color(100, 0, 0);
      } else if (randomizer <= 8) {
        state = "invulnerable";
        currentAction = "hook";
        reelTime = 200;
        pDamage = 300;
        counter = 150;
        //Sprite = hookStartStart
        c = color(0, 100, 0);
      } else {
        state = "invulnerable";
        currentAction = "uppercut";
        reelTime = 300;
        pDamage = 800;
        counter = 150;
        //Sprite = upperCutStart
        c = color(0, 0, 100);
      }
    }
    
    else {
      if (counter > 0) {
        counter --;
      } else {
        state = "block";
        currentAction = "idle";
        //Sprite = idle
        c = color(0, 0, 0);
        waitTime = int(random(30, 120));
        randomizer = int(random(10));
      }

      if (currentAction == "jab") {
        if (counter == 80) {
          //sprite = activePunch
          c = color(255, 0, 0);
          state = "attack";
        } else if (counter == 79) {
          state = "vulnerable";
        }
      } else if (currentAction == "hook") {
        if (counter == 100) {
          //sprite = hook
          c = color(255, 0, 0);
          state = "attack";
        } else if (counter == 99) {
          state = "vulnerable";
        }
      } else if (currentAction == "uppercut"){
        if (counter == 130) {
          //sprite = activePunch
          print("AA");
          c = color(255, 0, 0);
          state = "attack";
        } else if (counter == 129) {
          state = "vulnerable";
        }
      }
    }
  }
  
  void playerCheck(Player player){
    if(player.state == "attack"){
      if(state == "block"){
          c = color(200, 200, 200);
          currentAction = "block";
          state = "block";
          counter = 10;
          waitTime -= 30;
          health -= 1;
      } else if (state == "vulnerable"){
        currentAction = "reel";
        counter = reelTime;
        state = "open";
        c = color(255, 255, 255);
        health -= 15;
      } else if (state == "open"){
        health -= 15;
      }
      
    }
  }
  
  void stateReset(){
     state = "neutral";
     currentAction = "idle";
     counter = 0;
     waitTime = int(random(100, 300));
     //Sprite = Idle;
     c = color(0);
     
  }
}
