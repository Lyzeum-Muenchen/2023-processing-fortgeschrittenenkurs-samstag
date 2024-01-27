import java.io.*; 
// Importiere Klassen fuer das Lesen und Schreiben von Dateien

public static class Util {

  public static int loadHighscore(String path) {
    int highscore = 0;
    File f = new File(path);
    if (f.exists()) {
      try {
        BufferedReader reader = new BufferedReader(
          new FileReader(f)); // oeffne Datei im Lesemodus
        String content = reader.readLine(); // Lese erste Zeile ein
        reader.close(); // Schliesse Datei
        highscore = Integer.parseInt(content); // Text in Zahl umwandeln
      }catch (IOException ex) {
      }catch (NumberFormatException e) {
      }
    }
    return highscore;
  }
  public static void saveHighscore(String path, int score) {
    File f = new File(path);
    // Erstelle Ordner in dem die Datei liegt, 
    // falls der Ordner nicht existiert
    f.getParentFile().mkdir();
    try {
      PrintWriter writer = new PrintWriter(new FileWriter(f));
      writer.write(score + "\n");
      writer.close();
    }catch (IOException ex) {
    }
  }
  
}
