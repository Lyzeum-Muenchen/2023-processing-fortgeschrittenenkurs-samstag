public class Coin extends Item {
 
  public Coin(int x, int y, int speed, boolean isVisible) {
    // super(): Konstruktoraufruf der Oberklasse
    super(x, y, speed, isVisible, loadImage("icons//coin.png"));
    
  }
  
  public void onCollide(Player p) {
    p.score++;
    isVisible = false;
  }
}
