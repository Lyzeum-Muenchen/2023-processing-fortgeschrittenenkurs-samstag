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
  
  public void draw() {
    // zugedecktes Feld
    stroke(0);
    fill(50); 
    
    //mouseX;
    //mouseY;
    rect(x, y, tileLength, tileLength);
  }

}
