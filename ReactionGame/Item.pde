
public class Item {
  private int x, y, w, h;
  private int speed;
  private PImage image;
  
  public Item(int x, int y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    w = 50;
    h = 50;
    image = loadImage("icons//coin.png");
  }
  
  public void update() {
    // Item bewegt sich nach unten
    y = y + speed;
    // y += speed; // Alternative
  }
  public void draw() {
    // Item zeichnen
    // Methode image, Objekt image
    image(image, x, y, w, h);
  }
  
  public boolean intersects(int px, int py, int pw, int ph) {
    // item_left < p_right
    // item_right > p_left
    // item_top < p_bottom
    
    // item_bottom > p_top
    if (x < px + pw && x + w > px && y < py + ph && y + h > py) {
      return true;
    }
    return false;
  }
}
