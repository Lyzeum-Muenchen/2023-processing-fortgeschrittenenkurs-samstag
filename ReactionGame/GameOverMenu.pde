public class GameOverMenu {


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
  }
}
