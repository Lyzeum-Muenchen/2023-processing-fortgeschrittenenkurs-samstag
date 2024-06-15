import processing.net.Server;

Server myServer;
int val = 0;

void setup() {
  size(500, 500);
  // 0 - 65000
  
  myServer = new Server(this, 2024); // Portnummer
}

void draw() {
  val = (val + 1) % 255;
  background(val);
  myServer.write(val); // sende Nachricht an alle
  
}
