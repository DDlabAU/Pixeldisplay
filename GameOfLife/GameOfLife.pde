OPC opc;

int updateInterval = 10;
int deathDelay = 2000;
int stasisDelay = 8000;
int deathTime;
int stasisTime;
boolean dead = false;
boolean stasis = false;

int worldWidth = 12;
int worldHeight = 15;
boolean world[worldWidth][worldHeight];

void setup() {
  size(600, 800);

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map an 12x15 grid of LEDs to the center of the window, scaled to take up most of the space
  opc.ledGrid(0 * 64, 12, 4, width * 1/2, height * 1/5, width/13, height/17, 0, false, false);
  opc.ledGrid(1 * 64, 12, 4, width * 1/2, height * 2/5, width/13, height/17, 0, false, false);
  opc.ledGrid(2 * 64, 12, 4, width * 1/2, height * 3/5, width/13, height/17, 0, false, false);
  opc.ledGrid(3 * 64, 12, 4, width * 1/2, height * 4/5, width/13, height/17, 0, false, false);
}

void draw() {
  background(0);
  blendMode(ADD);
  update();
  show();
}

void update() {
  if (dead) {
    if(millis() > deathTime + deathDelay){
      initialize();
    }
  } else if (stasis) {
    if(millis() > stasisTime + stasisDelay){
      initialize();
    }
  } else {
    generate();
  }
}

void show() {

}

void initialize() {
  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      world[x][y] = random(2);
    }
  }
  dead = false;
  stasis = false;
}

void generate() {

}

void printWorld() {
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < w; y++) {
      print(world[x][y]);
      print(" ");
    }
    println();
  }
  println();
}
