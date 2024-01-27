public class Bomb extends Item {

  public Bomb(int x, int y, int speed, boolean isVisible) {
    // super(): Konstruktoraufruf der Oberklasse
    super(x, y, speed, isVisible, loadImage("icons//bomb.png"));
  }
  // grosse Bombe
  public Bomb(int x, int y, int w, int h, int speed, boolean isVisible) {
    // super(): Konstruktoraufruf der Oberklasse
    super(x, y, w, h, speed, isVisible, loadImage("icons//bomb.png"));
  }
  
  public void onCollide(Player p) {
    p.lives--;
    p.setPainAnimation(30);
    isVisible = false;
  }
}
