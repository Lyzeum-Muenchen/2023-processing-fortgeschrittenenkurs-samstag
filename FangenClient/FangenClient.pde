import processing.net.*;

Client myClient;
boolean[] keyPressed;
int[] codes = new int[]{38, 39, 40, 37};

void setup() {
  size(1280, 720);
  // Client initialisieren
  myClient = new Client(this, "127.0.0.1", 2024);
  keyPressed = new boolean[4]; // Up, Right, Down, Left
}
void keyPressed() {
  println(keyCode);
}
void keyReleased() {

}

void draw() {
  // Nachrichten verarbeiten
  // Welt zeichnen
}
