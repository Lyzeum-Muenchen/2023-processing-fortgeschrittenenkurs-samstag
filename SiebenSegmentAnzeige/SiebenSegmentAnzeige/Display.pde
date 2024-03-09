  /*
  Reihenfolge:
  0
  1, 2
  3
  4, 5
  6
    --
   |  |
   |  |
    --
   |  |
   |  |
    --
  
  */
public class Display {
  boolean[] segmentEnabled;
  private int startX, startY;
  public Display(int x, int y) {
    segmentEnabled = new boolean[7];
    startX = x;
    startY = y;
  }
  
  public void setNumber(int number) {
    segmentEnabled = new boolean[7];
    switch(number) {
      case 0:
        for (int i = 0; i < 7; i++){
          if (i != 3)
            segmentEnabled[i] = true;
        }
        break;
      case 1:
        segmentEnabled[2] = true;
        segmentEnabled[5] = true;
        break;
      case 2:
        // 0, 2, 3, 4, 6
        setSegments(new int[]{0, 2, 3, 4, 6});
        break;
      case 3:
        //0, 2, 3, 5, 6
        setSegments(new int[]{0, 2, 3, 5, 6});
        break;
      case 4:
        // 1, 2, 3, 5
        setSegments(new int[]{1, 2, 3, 5});
        break;
      case 5:
        // 0, 1, 3, 5, 6
        int[] arr5 = new int[]{0, 1, 3, 5, 6};
        setSegments(arr5);
        break;
      case 6:
        setSegments(new int[]{0, 1, 3, 4, 5, 6});
        break;
      case 7:
        setSegments(new int[]{0, 2, 5});
        break;
      case 8:
        setSegments(new int[]{0, 1, 2, 3, 4, 5, 6});
        break;
      case 9:
        setSegments(new int[]{0, 1, 2, 3, 5, 6});
    }
  }
  public void setSegments(int[] ids) {
    for (int i = 0; i <ids.length; i++) {
      segmentEnabled[ids[i]] = true; // aktiviere Segment mit Zahl im Array
    }
  }
  
  public void draw() {
    for (int i = 0; i < 7; i++) {
      // Farbe setzen
      if (segmentEnabled[i]) {
        fill(255, 0, 0);
      }else {
        fill(50);
      }
      switch (i) {
        case 0:
          // Rechteck ganz oben
          rect(startX + se, startY, le, se);
          break;
        case 1:
          // rechteck oben links
          rect(startX, startY + se, se, le);
          break;
        case 2:
          // oben rechts
          rect(startX + se + le, startY + se, se, le);
          break;
        case 3:
          // mitte
          rect(startX + se, startY + se + le, le, se);
          break;
        //------------ untere Haelfte
        case 4:
          // Rechteck unten links
          rect(startX, startY + le + 2 * se, se, le);
          break;
        case 5:
          // unten rechts
          rect(startX + se + le, startY + se + le + se, se, le);
          break;
        case 6:
          // unten
          rect(startX + se, startY + 2 * le + 2 * se, le, se);
          break;
      }
    }  
  }

}
