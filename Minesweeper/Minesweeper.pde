import java.util.Random;
/*
- Array an Kacheln
  - Mine oder Leer
  - Aufgedeckt oder zugedeckt
  - Flagge oder keine Flagge
  - Position und Größe der Kachel
- Kachelgröße
- Spielablauf:
  - Kacheln aufdecken
    - Fall MINE: GameOver
    - Fall LEERES FELD: 
      - Umliegende leere Felder aufdecken
      - Zahlen von aufgedeckten Felder anzeigen
    - Erstes Feld ist garantiert leer
      --> Minen erst jetzt generieren
    - Linksklick: Aktion Aufdecken
    - Rechtsklick: Flagge setzen/entfernen
- Schwierigkeitsgrad:
  - Spielfeldgröße:
  - Anzahl Minen
- Stoppuhr
*/
int tileLength = 40;
int tilesX = 32; // 1280 / 40
int tilesY = 16;
Tile[][] tiles;  // Array mit Kacheln
PImage imgMine; // Bild der Mine

void setup() {
  size(1280, 720);
  imgMine = loadImage("Mine.png");
  initGame();
  
}

void initGame() {
  // Initialisiere Array
  tiles = new Tile[tilesX][tilesY];
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      // x- und y-Position
      tiles[i][j] = new Tile(i * tileLength, 80 + j * tileLength);
    }
  }
}

void generateMines(int x, int y) {
  float probMine = 0.15; // zwischen 0 und 1
  Random random = new Random();
  // Nur Minen generieren
  for (int i = 0; i < tiles.length; i++) {
    for(int j = 0; j < tiles[0].length; j++) {
      // Ereignis Mine generieren tritt ein
      // Falls auf oder neben gewählter erster Kachel, dann keine Mine generieren
      boolean isMine = random.nextFloat() < probMine;
      tiles[i][j].isMine = isMine;
    }
  }
  // Minen im Spawnbereich entfernen
  for (int i = x - 1; i <= x + 1; i++) {
    for (int j = y - 1; j <= y + 1; j++) {
      if (i >= 0 && i < tiles.length && j >= 0 && j < tiles[0].length)
        tiles[i][j].isMine = false;
    }
  }
  // Methode zur Bestimmung der Minennachbarn
  computeMineCount();
}

void computeMineCount() {
  // Zähle Nachbarn für jede Kachel
  // Schleife über all Kachel: Rufe Hilfsmethode auf
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      tiles[i][j].mineCount = getMineCount(i, j);
    }
  }
}
// Hilfsmethode für eine Kachel, zähle Minen benachbart zur gewählten Kachel
int getMineCount(int x, int y) {
  int count = 0;
  for (int i = x - 1; i <= x + 1; i++) {
    for (int j = y - 1; j <= y + 1; j++) {
      if (i >= 0 && i < tiles.length && j >= 0 && j < tiles[0].length
        && tiles[i][j].isMine) {
        count++;
      }
    }
  }
  return count;
}


void clickTile(int x, int y) {

}

void mousePressed() {
  // finde Kachel, die gedrückt wurde
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      if (tiles[i][j].isInBounds()) {
        // Kachel deckt Feld auf
        // Spezialfall: Erste Kachel wird aufgedeckt -> Generiere Minen
        generateMines(i, j);
      }
    }
  }
}


void draw() {

  background(220);
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      tiles[i][j].draw();
    }
  }
  
  //smooth(4);
  //fill(0, 100, 255, 100); // RGB + Alpha, halbtransparent
  //circle(mouseX, mouseY, 40);
  
}
