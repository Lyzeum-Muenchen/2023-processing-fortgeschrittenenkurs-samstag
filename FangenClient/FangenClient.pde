import processing.net.*;

Client myClient;
boolean[] keysPressed;
final int[] codes = new int[]{38, 39, 40, 37};
final int[] codesAlternative = new int[]{87, 68, 83, 65};
Player player;
Tile[][] tiles;

void setup() {
  size(1280, 720);
  frameRate(120);
  // Client initialisieren
  myClient = new Client(this, "127.0.0.1", 2024);
  keysPressed = new boolean[4]; // Up, Right, Down, Left
  player = new Player(0, 0, 64, 64);
  setupWorld();
}

void setupWorld() {
  tiles = new Tile[10][10];
  int TILE_LENGTH = 64;
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      // Mauer am Rand oder auf (5,5) bzw. (5, 6)
      boolean isWall = i == 0 || i == tiles.length - 1
        || j == 0 || j == tiles[0].length - 1
        || (i == 5 && j >= 5 && j <= 6);
      tiles[i][j] = new Tile(i * TILE_LENGTH, j * TILE_LENGTH,
        TILE_LENGTH, TILE_LENGTH, isWall);
    }
  }
}

void keyPressed() {
  println(keyCode);
  for (int i = 0; i < 4; i++) {
    if (keyCode == codes[i]) {
      keysPressed[i] = true;
    }
  }
}
void keyReleased() {
  for (int i = 0; i < 4; i++) {
    if (keyCode == codes[i]) {
      keysPressed[i] = false;
    }
  }
}

void sendKeysPressed() {
  JSONObject msgObj = new JSONObject();
  // { "type": "actions",
  //   "actions": [...] }
  msgObj.setString("type", "actions");
  JSONArray arr = new JSONArray();
  for (int i = 0; i < keysPressed.length; i++) {
    arr.setBoolean(i, keysPressed[i]);
  }
  msgObj.setJSONArray("actions", arr);
  myClient.write(msgObj.toString());
}

void draw() {
  sendKeysPressed();
  // Nachrichten verarbeiten
  while (myClient.active() && myClient.available() > 0) {
    String msg = myClient.readString();
    JSONObject msgObj = parseJSONObject(msg);
    player.updatePosition(msgObj);
  }
  // Welt zeichnen
  background(220);
  
  for (int i = 0; i < tiles.length; i++) {
    for (int j = 0; j < tiles[0].length; j++) {
      
    }
  }
  player.draw();
}
