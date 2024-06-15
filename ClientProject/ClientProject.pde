import processing.net.Client;

Client myClient;
int value;

void setup() {
  size(500, 500);
  myClient = new Client(this, "127.0.0.1", 2024);
}

void draw() {
  if (myClient.available() > 0) {
    value = myClient.read();
  }
  background(value);
}
