public class Display {
  boolean[] segmentEnabled;
  
  /*
  Reihenfolge:
  0
  12
  3
  45
  6
    --
   |  |
   |  |
    --
   |  |
   |  |
    --
  
  */
  public Display() {
    segmentEnabled = new boolean[7];
    segmentEnabled[0] = true;
  }
  
  public void setNumber(int number) {
  
  }
  
  public void draw() {
    fill(255, 0, 0);
    // TODO: 7 Rechtecke zeichnen
    // Rechteck ganz oben
    rect(startX + se, startY, le, se);
    // rechteck oben links
    rect(startX, startY + se, se, le);
    // mitte
    rect(startX + se, startY + se + le, le, se);
    // oben rechts
    rect(startX + se + le, startY + se, se, le);
    //------------ untere Haelfte
    // Rechteck unten links
    rect(startX, startY + le + 2 * se, se, le);
    // unten rechts
    rect(startX + se + le, startY + se + le + se, se, le);
    // unten
    rect(startX + se, startY + 2 * le + 2 * se, le, se);
  }

}
