class Enemy {
  int health;
  String state; //States are vulnerable, block, dodge, attack, invulnerable, and down
  String currentAction; // Actions: idle, jab, hook, uppercut, block, dodge, reel
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
    } else if (waitTime == 0 && currentAction == "idle") {
      if (randomizer <= 5) {
        state = "invulnerable";
        currentAction = "jab";
        reelTime = 55;
        pDamage = 100;
        counter = 80;
        //Sprite = jabStart
        c = color(100, 0, 0);
      } else if (randomizer <= 8) {
        state = "invulnerable";
        currentAction = "hook";
        reelTime = 145;
        pDamage = 300;
        counter = 150;
        //Sprite = hookStartStart
        c = color(0, 100, 0);
      } else {
        state = "invulnerable";
        currentAction = "uppercut";
        reelTime = 314;
        pDamage = 800;
        counter = 150;
        //Sprite = upperCutStart
        c = color(0, 0, 100);
      }
    } else {
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
        if (counter == 60) {
          //sprite = activePunch
          c = color(255, 0, 0);
          state = "attack";
        } else if (counter == 59) {
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
        if (counter == 132) {
          //sprite = activePunch
          print("AA");
          c = color(255, 0, 0);
          state = "attack";
        } else if (counter == 131) {
          state = "vulnerable";
        }
      }
    }
  }
}
