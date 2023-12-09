public class IceBlock extends Item {
  public IceBlock(int x, int y, int speed, boolean visible) {
    super(x, y, speed, visible, 
      loadImage("icons//max-icons//snowball.png"));
  }
  public void onCollide(Player p) {
    if (p.isBurning) {
      // Effekt des Feuerballs aufheben
      p.isBurning = false;
    }else{
      // Eis-Effekt mit 15 Sekunden hinzufuegen
      p.isFreezing = true;
      p.effectDur = 15 * 60; // 15 * frameRate
    }
    isVisible = false; // Block entfernen
    
  }

}
