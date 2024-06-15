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

Bugs:
- Zeit läuft weiter, falls Spiel vorbei
- 
*/

/*
Aufgaben:
- Zeit vergangen
- Game Over (Mine getroffen ODER Alle Minen mit Flagge markieren)
Optionale Aufgaben:
- Schwierigkeitsgrad
  - Leicht: 10 x 10: 0.15625
  - Mittel: 16 x 16: 0.15625
  - Schwierig: 32x16: 0.20625
*/
final int OFFSET_Y = 80;
int tileLength = 40;
float probMine;

long timestamp; // Zeitstempel für Spielbeginn
long timestampEnd;

int availableFlags = 0; // Entspricht Gesamtzahl der Minen am Anfang des Spiels
Tile[][] tiles;  // Array mit Kacheln
PImage imgMine, imgFlag; // Bild der Mine
GameState state;
Button[] buttons;

void setup() {
  size(1280, 720);
  imgMine = loadImage("Mine.png");
  imgFlag = loadImage("Flag.png");
  
  state = GameState.SETUP;
  // Buttons für Schwierigkeitsgrad erstellen
  buttons = new Button[4];
  buttons[0] = new Button("Einfach");
  buttons[1] = new Button("Mittel");
  buttons[2] = new Button("Schwer");
  buttons[3] = new Button("Nochmal Spielen");
  for (int i = 0; i < 3; i++)  {
    buttons[i].setBounds(i * 200 + (i + 1) * 170, height/2 - 40, 200, 80);
  }
  buttons[3].setBounds(width - 250, 0, 200, 80);
}

void initGame(int tilesX, int tilesY, float probMine) {
  this.probMine = probMine;
  // Initialisiere Array
  tiles = new Tile[tilesX][tilesY];
  int offsetX = width/2 - (tilesX * tileLength)/2;
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      // x- und y-Position
      tiles[i][j] = new Tile(offsetX + i * tileLength, OFFSET_Y + j * tileLength);
    }
  }
  state = GameState.NOT_STARTED;
}

void generateMines(int x, int y) {
  Random random = new Random();
  availableFlags = 0;
  // Nur Minen generieren
  for (int i = 0; i < tiles.length; i++) {
    for(int j = 0; j < tiles[0].length; j++) {
      // Ereignis Mine generieren tritt ein
      // Falls auf oder neben gewählter erster Kachel, dann keine Mine generieren
      boolean isMine = random.nextFloat() < probMine;
      tiles[i][j].isMine = isMine;
      availableFlags += isMine ? 1 : 0; // Ternärer Operator
    }
  }
  // Minen im Spawnbereich entfernen
  for (int i = x - 1; i <= x + 1; i++) {
    for (int j = y - 1; j <= y + 1; j++) {
      if (isValidTile(i, j)) {
        availableFlags -= tiles[i][j].isMine ? 1 : 0; // Mine entfernen -> Flaggenzahl reduzieren
        tiles[i][j].isMine = false;
      }
    }
  }
  // Methode zur Bestimmung der Minennachbarn
  computeMineCount();
  timestamp = millis();
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
      if (isValidTile(i, j) && tiles[i][j].isMine) {
        count++;
      }
    }
  }
  return count;
}

boolean isValidTile(int x, int y) {
  return x >= 0 && x < tiles.length && y >= 0 && y < tiles[0].length;
}



void clickTile(int x, int y) {
  if (isValidTile(x, y) && !tiles[x][y].isVisible) {
    if (mouseButton == LEFT) {
      // Feld aufdecken
      tiles[x][y].isVisible = true;
      tiles[x][y].hasFlag = false;
      if (tiles[x][y].isMine) {
        timestampEnd = millis();
        state = GameState.GAME_LOST;
      }else if(tiles[x][y].mineCount == 0) {
        // falls 0 Minen in der Umgebung, dann Nachbarfelder aufdecken
        for (int i = x -1; i <= x + 1; i++) {
          for (int j = y - 1; j <= y + 1; j++) {
            clickTile(i, j);
          }
        }
      }
    }else if (mouseButton == RIGHT) {
      // Zustand invertieren
      // Keine Flagge auf dem Feld UND Flagge verfügbar -> Flagge setzen
      if (!tiles[x][y].hasFlag && availableFlags > 0) {
        tiles[x][y].hasFlag = !tiles[x][y].hasFlag;
        availableFlags--;
        if (isGameWon()) {
          timestampEnd = millis();
          state = GameState.GAME_WON;
        }
      }else if(tiles[x][y].hasFlag) {
        // Flagge entfernen
        tiles[x][y].hasFlag = false;
        availableFlags++;
      }
    }
  }
}

boolean isGameWon() {
  if (availableFlags == 0) {
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        if (tiles[i][j].hasFlag && !tiles[i][j].isMine)
            return false;
      }
    }
    return true; // Alle Felder mit Flagge liegen auf Minen
  }
  return false;
}

void mousePressed() {
  if (state == GameState.GAME_WON || state == GameState.GAME_LOST) {
    buttons[3].mousePressed();
  }else if(state == GameState.SETUP) {
    for (int i = 0; i < 3; i++) {
      buttons[i].mousePressed();
    }
    return;
  }
  // finde Kachel, die gedrückt wurde
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      if (tiles[i][j].isInBounds()) {
        // Spezialfall: Erste Kachel wird aufgedeckt -> Generiere Minen
        if (state == GameState.NOT_STARTED && mouseButton == LEFT) {
          generateMines(i, j);
          state = GameState.RUNNING;
        }
        
        if (state == GameState.RUNNING) {
          // Feld aufdecken ODER Flagge anzeigen bzw. verstecken
            clickTile(i, j);
        }
      }
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < 4; i++) {
    buttons[i].mouseReleased();
  }
}

void onButtonClicked(String label) {
  switch(label) {
    case "Einfach":
      initGame(10, 10, 0.15);
      break;
    case "Mittel":
      initGame(16, 16, 0.15);
      break;
    case "Schwer":
      initGame(32, 16, 0.20);
      break;
    case "Nochmal Spielen":
      state = GameState.SETUP;
  }
}

void draw() {

  background(220);
  if (state == GameState.SETUP) {
    for (int i = 0; i < 3; i++) {
      buttons[i].draw();
    }
    return; // Verlasse Funktion sofort
  }
  if (state == GameState.GAME_WON) {
    background(0, 255, 0); // Grüner Hintergrund, falls Spiel erfolgreich beendet wurde
  }else if(state == GameState.GAME_LOST) {
    background(255, 0, 0);
  }
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      tiles[i][j].draw();
    }
  }
  // Texteinblendungen
  // Einblendung verfügbarer Flaggen
  if (state != GameState.NOT_STARTED) {
    image(imgFlag, 140, 10, 50, 50);
    
  }
  if (state == GameState.RUNNING) {
    drawTimePassed((millis() - timestamp)/1000);
  }else if (state == GameState.GAME_WON || state == GameState.GAME_LOST) {
    drawTimePassed((timestampEnd - timestamp) / 1000);
    buttons[3].draw();
  }
  
  
  //fill(0, 100, 255, 100); // RGB + Alpha, halbtransparent
  //circle(mouseX, mouseY, 40);
}
void drawTimePassed(long value) {
  fill(255);
  textSize(40);
  text(availableFlags, 100, 50);
  text(value + "", width/2, 50); // Vergangene Zeit in Sekunden
}
