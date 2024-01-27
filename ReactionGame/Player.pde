public class Player {
  int x, y, w, h;
  int pSpeed = 10;
  boolean leftPressed, rightPressed;
  int score;
  int lives;
  
  boolean isFreezing, isBurning;
  int effectDur; // effectDuration, 
  PImage iconFreeze;
  PImage playerDefault, playerHappy, playerPain;
  boolean faceRight;
  int animState; // animationState, 0: Default, 1: Happy, 2: Pain
  int animDur; // animationDuration
  
  public Player() {
    x = 260;
    y = 700;
    w = 80;
    h = 80;
    lives = 1;
    score = 0;
    iconFreeze = loadImage("icons//max-icons//freeze7.png");
    playerDefault = loadImage("icons//max-icons//PlayerPig.png");
    playerHappy = loadImage("icons//max-icons//PlayerPigMONEY.png");
    playerPain = loadImage("icons//max-icons//PlayerPigPAIN.png");
  }
  public void setPainAnimation(int duration) {
    animState = 2;
    animDur = duration;
  }
  public void setHappyAnimation() {
    if (!isBurning && !isFreezing) {
      animState = 1;
      animDur = 30; // 30 Ticks = 0,5 Sekunden
    }
  }
  public void update() {
    if (animDur > 0) {
      animDur--;
      if (animDur == 0) {
        animState = 0; // auf Default setzen
      }
    }
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
    PImage selImg = playerDefault;
    if (animState == 1) {
      selImg = playerHappy;
    }else if(animState == 2) {
      selImg = playerPain;
    }
    image(selImg, x, y, w, h);
    
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
