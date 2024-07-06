public class Player {

  public boolean isCatcher;
  public int iconId;
  public Hitbox position;
  public boolean[] keysPressed; // UP, RIGHT, DOWN, LEFT
  
  public Player(int x, int y, int w, int h) {
    position = new Hitbox(x, y, w, h);
    isCatcher = false;
    iconId = 0;
    keysPressed = new boolean[4];
  }
  
  // Hoch, rechts, runter, links
  public void processMessageActions(boolean[] keysPressed) {
    this.keysPressed = keysPressed;
  }
  public void simulateStep() {
    // Bewegung des Spielers
    int speed = 10;
    int moveX = 0;
    int moveY = 0;
    if (keysPressed[0])
      moveY -= speed;
    if (keysPressed[1])
      moveX += speed;
    if (keysPressed[2])
      moveY += speed;
    if (keysPressed[3])
      moveX -= speed;
    position = position.move(moveX, moveY);
  }
  
  public JSONObject getPlayerData() {
    JSONObject msg = new JSONObject();
    msg.setInt("x", position.x);
    msg.setInt("y", position.y);
    msg.setInt("w", position.w);
    msg.setInt("h", position.h);
    return msg;
  }
  
}
