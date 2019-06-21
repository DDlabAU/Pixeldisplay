// Denne kode er en modificeret version af fadecandys egen eksempelkode der kan findes på dette repository: https://github.com/scanlime/fadecandy

OPC opc;
PImage dot;

void setup() {
  size(600, 800);

  // Load a sample image
  dot = loadImage("dot.png");

  initDisplay();
}

void draw() {
  background(0);

  // Draw the image, centered at the mouse location
  float dotSize = height * 0.7;
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
}

void initDisplay() {
  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  int wGrid = 12;
  int hGrid = 4;
  float wSpacing = width / 12;
  float hSpacing = height / 16;
  float xPos = width / 2;

  for (int i = 0; i < 4; i++) {
    float yPos = ((hGrid / 2) * hSpacing) + (i * hGrid * hSpacing);

    // Map an 12x16 grid of LEDs to the center of the window, scaled to take up most of the space
    opc.ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false, false);
    opc.ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false, false);
    opc.ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false, false);
    opc.ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false, false);
  }
}
