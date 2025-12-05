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

  Enemy() {
    health = 1000;
    state = "block";
    currentAction = "idle";
    sprite = loadImage("enemyIdle.png");
    waitTime = 144;
    reelTime = 0;
    pDamage = 0;
    counter  = 0;
    knockdowns = 0;
    roundKnockdowns = 0;
    randomizer = int(random(11));
    position = new PVector(320, 430);
  }

  void draw() {
    image(sprite, position.x, position.y);
  }

  void act() {
    if (waitTime > 0 && currentAction == "idle") {
      waitTime --;
    } else if (waitTime <= 0 && currentAction == "idle") {
      if (randomizer <= 5) {
        state = "invulnerable";
        currentAction = "jab";
        sprite = loadImage("enemyJabWindup.png");
        reelTime = 105;
        pDamage = 100;
        counter = 110;
        //Sprite = jabStart
      } else if (randomizer <= 8) {
        state = "invulnerable";
        currentAction = "hook";
        reelTime = 200;
        pDamage = 300;
        counter = 150;
        sprite = loadImage("enemyHookWindup.png");
      } else {
        state = "invulnerable";
        currentAction = "uppercut";
        sprite = loadImage("enemyUppercutWindup.png");
        reelTime = 300;
        pDamage = 800;
        counter = 150;
        //Sprite = upperCutStart
      }
    } else if (waitTime <= 0 && currentAction == "block") {
      if (randomizer <= 5) {
        state = "invulnerable";
        currentAction = "jab";
        sprite = loadImage("enemyJabWindup.png");
        reelTime = 105;
        pDamage = 100;
        counter = 110;
        //Sprite = jabStart
      } else if (randomizer <= 8) {
        state = "invulnerable";
        currentAction = "hook";
        sprite = loadImage("enemyHookWindup.png");
        reelTime = 200;
        pDamage = 300;
        counter = 150;
      } else {
        state = "invulnerable";
        currentAction = "uppercut";
        sprite = loadImage("enemyUppercutWindup.png");
        reelTime = 300;
        pDamage = 800;
        counter = 150;
        //Sprite = upperCutStart
      }
    } else {
      if (counter > 0) {
        counter --;
      } else {
        position = new PVector(320, 430);
        sprite = loadImage("enemyIdle.png");
        state = "block";
        currentAction = "idle";
        //Sprite = idle
        waitTime = int(random(30, 120));
        randomizer = int(random(10));
      }

      if (currentAction == "jab") {
        if (counter == 80) {
          position = new PVector(320, 500);
          sprite = loadImage("enemyJab.png");
          state = "attack";
        } else if (counter == 79) {
          state = "vulnerable";
        }
      } else if (currentAction == "hook") {
        if (counter == 100) {
          position = new PVector(320, 520);
          sprite = loadImage("enemyHook.png");
          state = "attack";
        } else if (counter == 99) {
          state = "vulnerable";
        }
      } else if (currentAction == "uppercut") {
        if (counter == 125) {
          position = new PVector(320, 520);
          sprite = loadImage("enemyUppercut.png");
          state = "attack";
        } else if (counter == 124) {
          state = "vulnerable";
        }
      }
    }
  }

  void playerCheck(Player player) {
    if (player.state == "attack") {
      if (state == "block") {
        sprite = loadImage("enemyBlock.png");
        currentAction = "block";
        state = "block";
        counter = 10;
        waitTime -= 30;
        health -= 5;
      } else if (state == "vulnerable") {
        position = new PVector(320, 430);
        currentAction = "reel";
        sprite = loadImage("enemyReel.png");
        counter = reelTime;
        state = "open";
        health -= 30;
      } else if (state == "open") {
        health -= 30;
      }
    }

    if (health <= 0) {
      sprite = loadImage("enemyDown.png");
      knockdowns ++;
      roundKnockdowns ++;
      state = "down";
      currentAction = "idle";
      counter = 0;
      waitTime = int(random(100, 300));
    }
  }

  void stateReset() {
    position = new PVector(320, 430);
    sprite = loadImage("enemyIdle.png");
    state = "block";
    currentAction = "idle";
    counter = 0;
    waitTime = int(random(100, 300));
  }
}
