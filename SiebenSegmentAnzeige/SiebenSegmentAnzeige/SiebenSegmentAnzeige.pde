

// Position der Sieben Segment Anzeige
int se = 20; // short edge
int le = 80; // long edge
int startX = 100;
int startY = 50;

Display disp; // 1.) Variable deklarieren
void setup() {
  size(500, 500);
  
  disp = new Display(); // 2.) Objekt initialisieren
  // Setze Ziffer
  disp.setNumber(0); // 3.) Anzuzeigende Ziffer setzen
  
}

void draw() {
  background(200);
  int number = 2;
  int firstDigit = number / 10;
  int secondDigit = number % 10;
  disp.draw(); // 4.) Zeichnen-Methode aufrufen
  
  // Aufgabe: 0 und 1 mit Sieben Segment Anzeige darstellen
  
}
