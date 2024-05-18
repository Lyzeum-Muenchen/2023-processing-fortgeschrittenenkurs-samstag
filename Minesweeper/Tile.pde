//- Mine oder Leer
//- Aufgedeckt oder zugedeckt
//- Flagge oder keine Flagge
//- Zahl

public class Tile {
  public boolean isMine;
  public boolean isVisible;
  public boolean hasFlag;
  public int mineCount;
  // final: Werte bleiben nach Setzen im Konstruktor unveränderbar
  public final int x, y; //- Position und Größe der Kachel

  
  public Tile(int x, int y) {
    isMine = false;
    isVisible = false;
    hasFlag = false;
    mineCount = 0;
    this.x = x;
    this.y = y;
    
  }
  // Liegt Mauszeiger innerhalb der Kachel?
  public boolean isInBounds() {
    return mouseX >= x && mouseX <= x+ tileLength
      && mouseY >= y && mouseY <= y + tileLength;
  }
  
  public void draw() {
    // zugedecktes Feld
    stroke(0);
    if (isInBounds()) {
      fill(220); // weiss
    }else if(isVisible) {
      fill(150); // schwarz/dunkelgrau
    }else {
      fill(50);
    }
    //mouseX;
    //mouseY;
    rect(x, y, tileLength, tileLength);
    // Falls aufgedeckt, Mine bzw. Zahl zeichnen
    if (isVisible) {
      if (isMine) {
        image(imgMine, x, y, tileLength, tileLength);
      }else if (mineCount != 0) {
        fill(255);
        textAlign(CENTER);
        textSize(20);
        text(mineCount + "", x + tileLength/2, y + tileLength/2);
      }
    }else if(hasFlag){
      // Hier Bild einfügen
      //fill(0, 0, 255);
      //rect(x, y, tileLength, tileLength);
      
      image(imgFlag, x, y, tileLength, tileLength);
    }
  }

}
