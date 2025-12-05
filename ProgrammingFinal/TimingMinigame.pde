class TimingMinigame {
  // This stores all of the variables for the class.
  PVector position;
  PVector squarePosition;
  PVector velocity;
  PVector acceleration;
  boolean win;

  TimingMinigame() {
    /*
    This sets the position of the bar, the green you aim for, and a 
    randomized position for the smaller white square
    */
    position = new PVector(200, 460);
    squarePosition = new PVector(int(random(200, 300)), 460);
    velocity = new PVector(3, 0);
    acceleration = new PVector(-.01, 0);
    win = false;
  }
  
  
  // This resets all the variables so the game can be played again on knockdown
  void resetMinigame(int k) {
    position = new PVector(200, 460);
    squarePosition = new PVector(int(random(200, 300)), 460);
    velocity = new PVector(3 + (k * 1), 0);
    acceleration = new PVector(-.0005 - (k * 0.0015), 0);
    win = false;
  }

  /* 
  This moves the small square by its velocity, and reverses the velocity if
  it hits the bounds of the bar. 
  */
  void act() {
    velocity.add(acceleration);
    squarePosition.add(velocity);

    if (squarePosition.x + 25 > position.x + 400 || squarePosition.x < position.x) {
      velocity.mult(-1);
      squarePosition.add(velocity);
      acceleration.mult(-1);
    }
  }
  
  /* 
  This checks if the w key is pressed, and stops the square. If its in the green,
  then win is set to true, which is checked to cause you to get up after winning the
  minigame.
  */
  void play(){
     if(keyPressed && key == 'w'){
        velocity = new PVector(0, 0);
        acceleration = new PVector(0, 0);
        if (squarePosition.x > position.x + 165 && squarePosition.x + 25 < position.x + 235){
          win = true;  
        }
     }
  }

  // This draws the minigame bar using rects.
  void draw() {
    fill(0);
    rect(position.x, position.y, 400, 40);
    fill(0, 255, 0);
    rect(position.x + 175, position.y, 50, 40);
    fill(255);
    rect(squarePosition.x, squarePosition.y, 25, 40);
  }
}
