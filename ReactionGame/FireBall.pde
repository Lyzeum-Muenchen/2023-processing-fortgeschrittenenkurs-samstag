public class FireBall extends Item {

  public FireBall(int x, int y, int speed, boolean visible) {
    super(x, y, 50, 90, speed, visible, 
    loadImage("icons//przemek-icons//fire_ball2.png"));
  }
  
  public void onCollide(Player p) {
    // Punkt hoeher als 15, dann Haelfte der Punkte abziehen
    // ansonsten -3
    if (p.isFreezing) {
      p.isFreezing = false;
    }else {
      p.isBurning = true;
      if (p.score <= 15) {
        p.effectDur = min(p.score, 3) * 60;
      }else {
        p.effectDur = (p.score / 2) * 60;
      }
    }
    isVisible = false;
  }

}
