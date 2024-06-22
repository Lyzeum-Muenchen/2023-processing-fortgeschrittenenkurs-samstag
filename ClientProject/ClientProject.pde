import processing.net.Client;

Client myClient;
int value;

void setup() {
  size(500, 500);
  String ipAdress = "192.168.178.154";
  myClient = new Client(this, ipAdress, 2024);
}

void draw() {
  if (myClient.available() > 0) {
    value = myClient.read();
  }
  background(value);
}
