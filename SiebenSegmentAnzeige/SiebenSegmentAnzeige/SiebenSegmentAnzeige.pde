
// Position der Sieben Segment Anzeige
int se = 20; // short edge
int le = 80; // long edge
int startX = 100;
int startY = 50;
int counter = 0;
Display[] disp; // 1.) Variable deklarieren
void setup() {
  size(1200, 500);
  disp = new Display[6];
  for (int i = 0; i < disp.length; i++) {
    disp[i] = new Display(startX + 2 * le * i, startY); // 2.) Objekt initialisieren
    // Setze Ziffer
    disp[i].setNumber(0); // 3.) Anzuzeigende Ziffer setzen
  }
}

void draw() {
  background(200);
  counter++;
  int number = counter / 60;
  if (number == 10) {
    counter = 0;
  }
  long ts = System.currentTimeMillis();
  int hours = (int)(((ts / 3600000)+ 1) % 24); // Zeitzone: Winter +1, Sommer +2
  int minutes = (int)((ts / 60000) % 60);
  int seconds = (int)((ts / 1000) % 60);
  // Displaywerte setzen
  println(hours);
  disp[0].setNumber(hours/ 10);
  disp[1].setNumber(hours % 10);
  disp[2].setNumber(minutes / 10);
  disp[3].setNumber(minutes % 10); // Mit Modulo-Operation EInser-Stelle herausfinden
  disp[4].setNumber(seconds / 10);
  disp[5].setNumber(seconds % 10);
  // Alle Sieben Segmente zeichnen
  for (int i = 0; i < disp.length; i++){
    disp[i].draw(); // 4.) Zeichnen-Methode aufrufen
  }
  // rote Punkte einfuegen
  fill(255, 0, 0);
  //stroke(50, 100, 150); // Randfarbe
  //noStroke(); // Kein Rand
  //strokeWeight(2); // Randdicke
  int yDot1 = startY - se + le;
  int yDot2 = startY + 3 * se + le;
  // Punkte zwischen Stunde und Minute
  rect(startX + le * 3 + se * 2 + se / 2, yDot1, se, se);
  rect(startX + le * 3 + se * 2 + se / 2, yDot2, se, se);
  // Punkte zwischen Minute und Sekunde
  rect(startX + le * 7 + se * 2 + se / 2, yDot1, se, se);
  rect(startX + le * 7 + se * 2 + se / 2, yDot2, se, se);
}
