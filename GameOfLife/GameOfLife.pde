OPC opc;

final ALIVE = true;
final DEAD = false;

boolean debugging = false;

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

  if(debugging) {
    printWorld();
  }
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
  int xPos;
  int yPos;
  int pWidth = width / worldWidth;
  int pHeight = height / worldHeight;

  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      xPos = x * pWidth;
      yPos = y * pHeight;

      if(world[x][y] == true){
        fill(255);
      } else {
        fill(0);
      }

      rect(xPos, yPos, pWidth, pHeight);
    }
  }
}

void initialize() {
  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      if(random(2) < 1){
        world[x][y] = ALIVE;
      } else {
        world[x][y] = DEAD;
      }
    }
  }
  dead = false;
  stasis = false;
}

void generate() {
  boolean newWorld[worldWidth][worldHeight];
  int stasisCount = 0;
  int liveDots = 0;
  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      int neighbors = 0;
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int xIndex = x + i;
          int yIndex = y + j;
          if (xIndex >= 0 && xIndex < w && yIndex >= 0 && yIndex < w) {
            if(world[x + i][y + j] == ALIVE) {
              neighbors++;
            }
          }
        }
      }

      if(world[x][y] == ALIVE) {
        neighbors--;
      }

      if ((world[x][y] == ALIVE) && (neighbors <  2)) {
        newWorld[x][y] = DEAD;           // Loneliness
      } else if ((world[x][y] == ALIVE) && (neighbors >  3)) {
        newWorld[x][y] = DEAD;           // Overpopulation
      } else if ((world[x][y] == DEAD) && (neighbors == 3)) {
        newWorld[x][y] = ALIVE;           // Reproduction
      } else {
        newWorld[x][y] = world[x][y];  // Stasis
        stasisCount++;
      }
      if(world[x][y] == ALIVE) {
        liveDots++;
      }
    }
  }

  if(liveDots == 0) {
    dead = true;
    deathTime = millis();
  }
  if(stasisCount == 64) {
    stasis = true;
    stasisTime = millis();
  }

  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      world[x][y] = newWorld[x][y];
    }
  }
}

void printWorld() {
  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      print(world[x][y]);
      print(" ");
    }
    println();
  }
  println();
}
