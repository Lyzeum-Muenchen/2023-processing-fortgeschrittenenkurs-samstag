public class Hitbox {
  public int x, y, w, h;
  
  public Hitbox(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public Hitbox move(int moveX, int moveY) {
    return new Hitbox(x + moveX, y + moveY, w, h);
  }
  
  public boolean collidesWith(Hitbox other) {
    // linke Seite Spieler < rechte Seite Wand
    // linke Seite Wand < rechte Seite Spieler
    return x < other.x + other.w && other.x < x + w
      && y < other.y + other.h && other.y < y + h;
  }
}
