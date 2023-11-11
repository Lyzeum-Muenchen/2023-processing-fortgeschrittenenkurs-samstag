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

Item[] items = new Item[10];

Random r = new Random();
int counterNewItem;
PImage iconHeart;
Player player1;
// Wahrscheinlichkeiten fuer Punktzahl 0 bis 50
// Muenze, Bombe, Medikit, gr. Bombe, Container
// Eisblock, Feuerball, Minimuenze, Schatzkiste, Zufallsbox

// Hausaufgabe 11.11.23: Bilder zeichnen:
// - Eisblock
// - Feuerball
// - Schatzkiste (Rechteckig)
// - Zufallsbox
// --> Quadratisch (128 x 128 Pixel)
// --> Rechteckig (256 x 128 Pixel)
int[] probRound50 = new int[]{50, 15, 13, 0, 0, 10, 10, 0, 0, 2};

void setup() {

  size(600, 800); // Fenstergroesse, 1920 * 1080
  iconHeart = loadImage("icons//heart.png");
  
  player1 = new Player();
  
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
  player1.keyPressed();
}

void keyReleased() {
  player1.keyReleased();
}

void draw() {
  //Gamelogik/Updatelogik
  player1.update();
  
  for (int i = 0; i < items.length; i++) {
    items[i].update();
    if (items[i].intersects(player1)) {
      items[i].onCollide(player1);
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
  
  player1.draw();
  
  for (int i = 0; i < items.length; i++) {
    items[i].draw();
  }
  
  for (int i = 0; i < player1.lives; i++) {
    image(iconHeart, 10 + i * 60, 30, 50, 50);
  }
  
  fill(255); // gleich wie fill(255, 255, 255);
  textSize(50);
  textAlign(CENTER);
  text(player1.score + "", width/2, 80);
}

//void drawTestItem() {
//   // Testroutine Kollision
//  Item itemTest = new Coin(500, 300, 0, true);
//  if (itemTest.intersects(mouseX, mouseY, 50, 50)) {
//    //println("Kollision");
//    stroke(250, 0, 0); // rot
//  }else {
//    //println("Keine Kollision");
//    stroke(20, 250, 30); // gruen
//  }
//  itemTest.draw();
//  noFill();
//  rect(mouseX, mouseY, 50, 50);
//}
