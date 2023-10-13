
public class Item {
  private int x, y, w, h;
  private int speed;
  
  public Item(int x, int y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    w = 50;
    h = 50;
  }
  
  public void update() {
    // Variable aendern
  }
  public void draw() {
    // Item zeichnen
  }
  
  public boolean intersects(int px, int py, int pw, int ph) {
    return false;
  }
}
