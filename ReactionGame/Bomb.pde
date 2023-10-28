public class Bomb extends Item {

  public Bomb(int x, int y, int speed, boolean isVisible) {
    // super(): Konstruktoraufruf der Oberklasse
    super(x, y, speed, isVisible, loadImage("icons//bomb.png"));
  }
  
  public void onCollide() {
    lives--;
    score = score - 5;
    isVisible = false;
  }
}
