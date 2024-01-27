public class Container extends Item {
  private PImage iconWarning;
  private long tsStart; // timestamp
  public Container(int x, int y, int w, int h, int speed,
    boolean visible) {
    super(x, y, w, h, speed, visible, 
      loadImage("icons//container.png"));
    iconWarning = loadImage("icons//danger.png");
    tsStart = millis() + 1000;
  }
  
  
  public void update() {
    if (isVisible) {
      if (millis() < tsStart) {
        // Phase 1: Zeige Warnung an
      }else {
        // Phase 2: Bewege Container
        y = y + speed;
        if (y > height)
          isVisible = false;
        
      }
    }
  }
  
  public void draw() {
    if (isVisible) {
      if (millis() < tsStart) {
        // Phase 1: Warnung anzeigen
        int wWarning = 80;
        int hWarning = 80;
        int xWarning = x + w/2 - wWarning/2;
        image(iconWarning, xWarning, 0, wWarning, hWarning);
      }else {
        // Phase 2: Container anzeigen
        image(image, x, y, w, h);
      }
    }
  }
  
  public void onCollide(Player p) {
    p.lives -= 2;
    soundMetal.play();
    p.setPainAnimation(30);
    isVisible = false;
  }
}
