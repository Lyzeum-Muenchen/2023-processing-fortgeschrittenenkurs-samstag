public class Tile {
  // Position, Groesse, istWand
  float x, y, w, h;
  boolean isWall;
  
  public Tile(float x, float y, float w, float h, boolean isWall) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.isWall = isWall;
  }
  public void draw() {
    if (isWall) {
      fill(0);
      rect(x, y, w, h);
    }
  }
}
