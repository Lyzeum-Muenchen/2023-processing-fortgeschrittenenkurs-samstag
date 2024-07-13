public class Player {
  private int x, y, w, h;
  public Player (int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  public void updatePosition(JSONObject playerData) {
    this.x = playerData.getInt("x");
    this.y = playerData.getInt("y");
    this.w = playerData.getInt("w");
    this.h = playerData.getInt("h");
  }
  
  public void draw() {
    fill(255, 0, 0);
    rect(x, y, w, h);
  }

}
