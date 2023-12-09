public class Player {
  int x, y, w, h;
  int pSpeed = 10;
  boolean leftPressed, rightPressed;
  int score;
  int lives;
  
  boolean isFreezing, isBurning;
  int effectDur; // effectDuration, 
  PImage iconFreeze;
  
  public Player() {
    x = 260;
    y = 700;
    w = 80;
    h = 80;
    lives = 1;
    score = 0;
    iconFreeze = loadImage("icons//max-icons//freeze7.png");
  }
  
  public void update() {
    float baseSpeed = 1.0; // (Gleitkomma-) Zahlen, z.B. 0.5, - 3.0
    if (isFreezing) {
      baseSpeed = 0.7;
      baseSpeed = 1 - 0.8 * (((float)effectDur) / (15 * 60));
      effectDur--;
      if (effectDur == 0) {
        isFreezing = false; // Verlangsamen nach 15 Sekunden aufheben
      }
    }
    // Spieler bewegt sich
    if (leftPressed == true) {
      x -= (int)(pSpeed * baseSpeed);
      if (x < 0) {
        x = 0;
      }
    }
    if (rightPressed == true) {
      x += (int)(pSpeed * baseSpeed);
      if (x + w > width) {
        x = width - w;
      }
      // height
    }
    // Feuer-Effekt
    if (isBurning) {
      effectDur--;
      // jede Sekunde wird ein Punkt abgezogen
      // FrameRate 60
      if (effectDur % 60 == 0) {
        score--;
      }
      if (effectDur <= 0) {
        isBurning = false;
      }
    }
    
  }
  public void draw() {
    // Spieler zeichnen
    noStroke(); // ohne sichtbaren Rahmen zeichnen
    fill(255, 0, 0); // rot
    rect(x, y, w, h);
    
    if (isFreezing) {
      image(iconFreeze, x - 10, y - 10, w + 20, h + 20);
    }
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
