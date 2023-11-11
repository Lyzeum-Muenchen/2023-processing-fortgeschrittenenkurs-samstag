public class Player {
  int x, y, w, h;
  int pSpeed = 10;
  boolean leftPressed, rightPressed;
  int score;
  int lives;
  
  public Player() {
    x = 260;
    y = 700;
    w = 80;
    h = 80;
    lives = 1;
    score = 0;
  }
  
  public void update() {
    // Spieler bewegt sich
    if (leftPressed == true) {
      x -= pSpeed;
      if (x < 0) {
        x = 0;
      }
    }
    if (rightPressed == true) {
      x += pSpeed;
      if (x + w > width) {
        x = width - w;
      }
      // height
    }
  }
  public void draw() {
    // Spieler zeichnen
    noStroke(); // ohne sichtbaren Rahmen zeichnen
    fill(255, 0, 0); // rot
    rect(x, y, w, h);
  }
  public void keyPressed() {
    // 37: linke Pfeiltaste
    // 39: rechte Pfeiltaste
    if (keyCode == 37) {
      leftPressed = true;
    }
    if (keyCode == 39) {
      rightPressed = true;
    }
  }
  public void keyReleased() {
    if (keyCode == 37) {
      leftPressed = false;
    }
    if (keyCode == 39) {
      rightPressed = false;
    }
  }
}
