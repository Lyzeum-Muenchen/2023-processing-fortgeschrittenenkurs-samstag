public class Coin extends Item {
   private int points;
  public Coin(int x, int y, int speed, boolean isVisible) {
    // super(): Konstruktoraufruf der Oberklasse
    super(x, y, speed, isVisible, loadImage("icons//coin.png"));
    points = 1;
  }
  public Coin(int x, int y, int w, int h, 
    int speed, int points, boolean isVisible) {
    // super(): Konstruktoraufruf der Oberklasse
    super(x, y, w, h, speed, isVisible, loadImage("icons//coin.png"));
    this.points = points;
  }
  
  public void onCollide(Player p) {
    p.score += points;
    isVisible = false;
    p.setHappyAnimation();
    soundCoin.play();
  }
}
