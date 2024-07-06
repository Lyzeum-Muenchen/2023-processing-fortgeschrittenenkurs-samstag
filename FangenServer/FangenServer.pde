import processing.net.*;

Server myServer;
private int TILE_LENGTH = 64;
Player player = new Player(0, 0, TILE_LENGTH, TILE_LENGTH);

void setup() {
  myServer = new Server(this, 2024);
}


void draw() {
  // 1.) Empfangene Nachrichten verarbeiten
  // - Gedrückte Tasten
  // - Join Server
  // Verarbeite alle verfügbaren Nachrichten
  Client nextClient = myServer.available();
  while(nextClient != null) {
    // Suche nach verfügbarer Nachricht vom Client
    while(nextClient.available() > 0) {
      String message = nextClient.readString();
      JSONObject msgObj = parseJSONObject(message); // String --> JSON-Object
      processMessage(msgObj, nextClient);
    }
    
    nextClient = myServer.available(); // suche nächsten Client
  }
  
  // 2.) Simulation der Welt
  // - Bewegung der Spieler (Kollisionen)
  // - Fangen-Check, Aktionen durchführen (mit Items, in der Spielwelt)
  // - Spielstart --> Rollenverteilung
  player.simulateStep();
  // 3.) Übermittlung der Spielwelt an Clients
  String worldData = player.getPlayerData().toString();
  myServer.write(worldData);
}


void processMessage(JSONObject msg, Client client) {
  String type = msg.getString("type");
  if (type.equals("actions")) {
    boolean[] actions = msg.getJSONArray("actions").getBooleanArray();
    player.processMessageActions(actions);
  }
}
