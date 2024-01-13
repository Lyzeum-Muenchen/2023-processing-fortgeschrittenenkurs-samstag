public class GameOverMenu extends Menu {


  public GameOverMenu() {
  
  }
  
  
  public void draw() {
    // Hintergrund zeigt Spiel
    // Schwarz + Halbtransparenz
    fill(0, 0, 0, 120);
    rect(0, 0, width, height);
    textAlign(CENTER);
    textSize(80);
    fill(255); // weiss
    text("Game Over", width/2, height/4);
    text("Your Score: " + player1.score, width/2, height/2);
    textSize(40);
    text("Highscore: " + highscore, width/2, 200 + height/2);
    text("Press SPACE to Restart", width/2, 280 + height/2);
  }
  
  public void keyReleased() {
  }
  
  public void keyPressed() {
    // wenn Leertaste gedrueckt, dann neues Spiel starten
    println(keyCode);
    if (keyCode == 32) {
      initGame();
    }
  }
}
