public class IceBlock extends Item {
  public IceBlock(int x, int y, int speed, boolean visible) {
    super(x, y, speed, visible, 
      loadImage("icons//max-icons//snowball.png"));
  }
  public void onCollide(Player p) {
  }

}
