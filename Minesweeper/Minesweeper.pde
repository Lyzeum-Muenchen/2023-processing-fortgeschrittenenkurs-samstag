
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
void setup() {
  size(1280, 720);
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


void draw() {

  background(220);
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      tiles[i][j].draw();
    }
  }
  
  smooth(4);
  fill(0, 100, 255, 100); // RGB + Alpha, halbtransparent
  circle(mouseX, mouseY, 40);
  
}
