// Spielerposition und Grösse
int x, y, w, h;
int pSpeed = 10;
boolean leftPressed, rightPressed;

void setup() {

  size(600, 800); // Fenstergroesse, 1920 * 1080
  x = 260;
  y = 700;
  w = 80;
  h = 80;
}

void keyPressed() {
  println(key);
  println(keyCode);
  // 37: linke Pfeiltaste
  // 39: rechte Pfeiltaste
  if (keyCode == 37) {
    leftPressed = true;
  }
  if (keyCode == 39) {
    rightPressed = true;
  }
}

void keyReleased() {
  if (keyCode == 37) {
    leftPressed = false;
  }
  if (keyCode == 39) {
    rightPressed = false;
  }
}

void draw() {
  //Gamelogik/Updatelogik
  
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
  }
  
  // Zeichnen
  background(20, 100, 200); // rot, gruen, blau: Werte von 0-255
  // Spieler zeichnen
  noStroke(); // ohne sichtbaren Rahmen zeichnen
  fill(255, 0, 0); // rot
  rect(x, y, w, h);
  
  
}
