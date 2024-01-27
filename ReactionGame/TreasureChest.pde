public class TreasureChest extends Item {
  private int points;

  public TreasureChest(int x, int y, int w, int h, 
    int speed, int points, boolean isVisible) {
    // super(): Konstruktoraufruf der Oberklasse
    super(x, y, w, h, speed, isVisible, 
      loadImage("icons//treasure_chest_maxi.png"));
    this.points = points;
  }
  
  public void onCollide(Player p) {
    p.score += points;
    isVisible = false;
    soundCoin.play();
    p.setHappyAnimation();
  }

}
