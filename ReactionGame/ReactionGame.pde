import java.util.Random;

// https://github.com/Lyzeum-Muenchen/2023-processing-fortgeschrittenenkurs-samstag
// Plaene:
// - Bombe: Spiel beenden
// - Leben: Bonusleben erhalten
// - Items groesser/kleiner
// - Menue
// - Animation: Fade In/ Fade Out
// - Game Over
// Spielmodi:
// - Zeitmodus: (60 Sekunden)
// - Endlosmodus
// - Koopmodus (Bombe alle 25 Punkte verfuegbar)

// Spielerposition und Groesse
int x, y, w, h;
int pSpeed = 10;
boolean leftPressed, rightPressed;
Item[] items = new Item[10];
int score;
Random r = new Random();
int counterNewItem;
int lives;
PImage iconHeart;

void setup() {

  size(600, 800); // Fenstergroesse, 1920 * 1080
  iconHeart = loadImage("icons//heart.png");
  x = 260;
  y = 700;
  w = 80;
  h = 80;
  lives = 1;
  for (int i = 0; i < items.length; i++) {
    items[i] = new Coin(275, -100, 10, false);
  }
  
}

void spawnItem() {
  // 1.) finde freien Platz im Array
  int freeIndex = -1;
  for (int i = 0; i < items.length; i++) {
    if (items[i].isVisible == false) {
      freeIndex = i;
      break; // verlasse Schleife
    }
  }
  
  // 2.) Erstelle neues Item
  // Falls Item erstellt werden kann
  if (freeIndex != -1) {
    int y = -100;
    int w = 50;
    int h = 50;
    // ausseren 5 Pixel nicht als Spawnpunkt
    int x = 5 + r.nextInt(width - w - 10); 
    int speed = 10 + r.nextInt(5); // 10-14
    
    int randomNumber = r.nextInt(2); // Zahlen 0 und 1 moeglich
    if (randomNumber == 0) {
      items[freeIndex] = new Coin(x, y, speed, true);
    }else if(randomNumber == 1) {
      items[freeIndex] = new Bomb(x, y, speed, true);
    }
  }
}

void keyPressed() {
  //println(key);
  //println(keyCode);
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
  for (int i = 0; i < items.length; i++) {
    items[i].update();
    if (items[i].intersects(x, y, w, h)) {
      items[i].onCollide();
    }
  }
  // Spawne neue Items
  counterNewItem--;
  if (counterNewItem <= 0){
    counterNewItem = 60;
    spawnItem();
  }
  
  
  // Zeichnen
  background(20, 100, 200); // rot, gruen, blau: Werte von 0-255
  // Spieler zeichnen
  noStroke(); // ohne sichtbaren Rahmen zeichnen
  fill(255, 0, 0); // rot
  rect(x, y, w, h);
  
  for (int i = 0; i < items.length; i++) {
    items[i].draw();
  }
  
  for (int i = 0; i < lives; i++) {
    image(iconHeart, 10 + i * 60, 30, 50, 50);
  }
  
  fill(255); // gleich wie fill(255, 255, 255);
  textSize(50);
  textAlign(CENTER);
  text(score + "", width/2, 80);
}

void drawTestItem() {
   // Testroutine Kollision
  Item itemTest = new Coin(500, 300, 0, true);
  if (itemTest.intersects(mouseX, mouseY, 50, 50)) {
    //println("Kollision");
    stroke(250, 0, 0); // rot
  }else {
    //println("Keine Kollision");
    stroke(20, 250, 30); // gruen
  }
  itemTest.draw();
  noFill();
  rect(mouseX, mouseY, 50, 50);
}
