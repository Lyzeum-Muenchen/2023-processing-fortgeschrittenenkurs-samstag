// TODO
public class MediKit extends Item {
  public MediKit(int x, int y, int speed, boolean visible) {
    super(x, y, speed, visible, loadImage("icons//medikit.png"));
  }
  
  public void onCollide(Player p) {
    if (p.lives < 3) {
      p.lives++;
    }else {
      p.score += 3;
    }
    p.setHappyAnimation();
    isVisible = false;
  }
}
