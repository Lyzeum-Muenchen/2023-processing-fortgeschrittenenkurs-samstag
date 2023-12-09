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
int[] prob50 = new int[]{50, 15, 13, 0, 0, 10, 10, 0, 0, 2};
int[] probTest = new int[]{0, 0, 0, 0, 0, 50, 50, 0, 0, 0};
String[] labels = new String[]{"Coin", "Bomb", "MediKit",
  "Large Bomb", "Container", "Iceblock", "Fireball", 
  "Mini Coin", "Treasure Chest", "Potion"};

void setup() {

  size(600, 800); // Fenstergroesse, 1920 * 1080
  iconHeart = loadImage("icons//heart.png");
  
  player1 = new Player();
  
  for (int i = 0; i < items.length; i++) {
    items[i] = new Coin(275, -100, 10, false);
  }
  showProbabilities(prob50);
  showProbabilities(probTest);
} // ENDE setup()
// gebe auf der Konsole Wahrscheinlichkeiten fuer Items aus
void showProbabilities(int[] probs) {
  int sum = 0;
  for (int i = 0; i < labels.length; i++) {
    println(labels[i] + ": " + probs[i] + "%");
    sum += probs[i];
  }
  println("Sum Probabilities: " + sum + "%");
  println("---------------");
}

public int getFreeIndex() {
  int freeIndex = -1;
  for (int i = 0; i < items.length; i++) {
    if (items[i].isVisible == false) {
      freeIndex = i;
      break; // verlasse Schleife
    }
  }
  return freeIndex;
}
// TODO Variable fuer Multiplayer
void spawnItem() {
  // 1.) finde freien Platz im Array
  int freeIndex = getFreeIndex();
  // Falls Item erstellt werden kann
  if (freeIndex != -1) {
    
    // items[freeIndex] = new IceBlock(x, y, speed, true);
    // 2.) Waehle Wahrscheinlichkeitsverteilung (Punktzahl abhaengig)
    int[] probs = prob50;
    probs = probTest;
    // 3.) Waehle zufaelligen Index
    int randomNumber = r.nextInt(100); // 0 bis 99
    int sumProbs = 0;
    int index = -1;
    for (int i = 0; i < probs.length; i++) {
      sumProbs += probs[i];
      if (randomNumber < sumProbs) {
        index = i;
        break;
      }
    }
    int y = -100;
    int w = 50;
    int h = 50;
    if (index == 3) {
      // large bomb
      w = 80;
      h = 80;
      println("large Bomb");
    }
    if(index == 7) {
      w = 25; // mini coin
      h = 25;
      println("Mini Coin");
    }
    // ausseren 5 Pixel nicht als Spawnpunkt
    int x = 5 + r.nextInt(width - w - 10); 
    int speed = 10 + r.nextInt(5); // 10-14
    
    // 4.) Gebe zufaelliges Item zurueck
    switch(index) {
      case 0:
        items[freeIndex] = new Coin(x, y, speed, true);
        break;
      case 1:
        items[freeIndex] = new Bomb(x, y, speed, true);
        break;
      case 2:
        items[freeIndex] = new MediKit(x, y, speed, true);
        break;
      case 3:
         // large bomb
        items[freeIndex] = new Bomb(x, y, w, h, speed, true);
        break;
      case 4:
        // TODO Container
      case 5:
        // IceBlock
        items[freeIndex] = new IceBlock(x, y, speed, true);
        break;
      case 6:
        // FireBall
        items[freeIndex] = new FireBall(x, y, speed, true);
        break;
      case 7:
        // MiniCoin, 3 Punkte
        items[freeIndex] = new Coin(x, y, w, h, speed * 2, 3, true);
        break;
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
