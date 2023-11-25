
public abstract class Item {
  protected int x, y, w, h;
  private int speed;
  // protected: Variable in dieser und jeder Unterklasse sichtbar
  protected PImage image; 
  protected boolean isVisible;
  
  public Item(int x, int y, int speed, boolean isVisible, 
    PImage image){
      // rufe zweiten Konstruktor auf mit hardkodierten Werten
    this(x, y, 50, 50, speed, isVisible, image);
  }
  
  public Item(int x, int y, int w, int h, int speed, 
  boolean isVisible, PImage image) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.isVisible = isVisible; // ist Item im Spiel sichtbar
    this.w = w;
    this.h = h;
    this.image = image;
  }
  
  public void update() {
    // Item bewegt sich nach unten
    if (isVisible) {
      y = y + speed;
      // Items aus dem Spiel nehmen, falls sie bereits 
      // durch das Fenster geflogen sind.
      if (y > height) {
        isVisible = false;
      }
    }
    
    // y += speed; // Alternative
  }
  public void draw() {
    // Item zeichnen
    // Methode image, Objekt image
    if (isVisible) {
      image(image, x, y, w, h);
    }
  }
  // Event, falls Item mit Spieler kollidiert
  // abstrakte Methode: Unterklasse muss diese Funktion 
  // implementieren
  public abstract void onCollide(Player p); 
  
  public boolean intersects(Player p) {
    // item_left < p_right
    // item_right > p_left
    // item_top < p_bottom
    
    // item_bottom > p_top
    if (isVisible && x < p.x + p.w && x + w > p.x && y < p.y + p.h && y + h > p.y) {
      return true;
    }
    return false;
  }
}
