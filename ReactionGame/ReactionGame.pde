// https://github.com/Lyzeum-Muenchen/2023-processing-fortgeschrittenenkurs-samstag
// Hausaufgabe:
// Item entfernen, wenn es kollidiert
// Item respawnen
// Itemideen ueberlegen

// Spielerposition und Grösse
int x, y, w, h;
int pSpeed = 10;
boolean leftPressed, rightPressed;
Item item;
int score;

void setup() {

  size(600, 800); // Fenstergroesse, 1920 * 1080
  x = 260;
  y = 700;
  w = 80;
  h = 80;
  item = new Item(275, -100, 10);
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
    // height
  }
  item.update();
  if (item.intersects(x, y, w, h)) {
    score += 1;
  }
  
  
  // Zeichnen
  background(20, 100, 200); // rot, gruen, blau: Werte von 0-255
  // Spieler zeichnen
  noStroke(); // ohne sichtbaren Rahmen zeichnen
  fill(255, 0, 0); // rot
  rect(x, y, w, h);
  
  item.draw();
  
  fill(255); // gleich wie fill(255, 255, 255);
  textSize(50);
  textAlign(CENTER);
  text(score + "", width/2, 80);
  
  // Testroutine Kollision
  Item itemTest = new Item(500, 300, 0);
  if (itemTest.intersects(mouseX, mouseY, 50, 50)) {
    println("Kollision");
    stroke(250, 0, 0); // rot
  }else {
    println("Keine Kollision");
    stroke(20, 250, 30); // gruen
  }
  itemTest.draw();
  noFill();
  rect(mouseX, mouseY, 50, 50);
}
