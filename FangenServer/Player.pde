public class Player {

  public boolean isCatcher;
  public int iconId;
  public Hitbox position;
  
  public Player(int x, int y, int w, int h) {
    position = new Hitbox(x, y, w, h);
    isCatcher = false;
    iconId = 0;
  }
  
  // Hoch, runter, links, rechts
  // 
  public void processAction(Action a) {
    
  }
  
}
