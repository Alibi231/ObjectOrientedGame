class TimingMinigame {
  PVector position;
  PVector squarePosition;
  PVector velocity;
  PVector acceleration;
  boolean win;

  TimingMinigame() {
    position = new PVector(200, 460);
    squarePosition = new PVector(int(random(200, 300)), 460);
    velocity = new PVector(3, 0);
    acceleration = new PVector(-.01, 0);
    win = false;
  }

  void resetMinigame(int k) {
    position = new PVector(200, 460);
    squarePosition = new PVector(int(random(200, 300)), 460);
    velocity = new PVector(k * 3, 0);
    acceleration = new PVector(-.0005 * (k*.75), 0);
    win = false;
  }

  void act() {
    velocity.add(acceleration);
    squarePosition.add(velocity);

    if (squarePosition.x + 25 > position.x + 400 || squarePosition.x < position.x) {
      velocity.mult(-1);
      squarePosition.add(velocity);
      acceleration.mult(-1);
    }
  }
  
  void play(){
     if(keyPressed && key == 'w'){
        velocity = new PVector(0, 0);
        acceleration = new PVector(0, 0);
        if (squarePosition.x > position.x + 175 && squarePosition.x + 25 < position.x + 225){
          win = true;  
        }
     }
  }

  void draw() {
    fill(0);
    rect(position.x, position.y, 400, 40);
    fill(0, 255, 0);
    rect(position.x + 175, position.y, 50, 40);
    fill(255);
    rect(squarePosition.x, squarePosition.y, 25, 40);
  }
}
