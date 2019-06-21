OPC opc;

final boolean ALIVE = true;
final boolean DEAD = false;

color pixelColor = color(255, 210);
color backgroundColor = color(0);

boolean debugging = false;

int updateRate = 3;
int maxRunTime = 30000;
int initializationTime;
int deathDelay = 2000;
int stasisDelay = 4000;
int deathTime;
int stasisTime;
boolean death = false;
boolean stasis = false;

int worldWidth = 12;
int worldHeight = 16;
boolean[][] world = new boolean[worldWidth][worldHeight];

ArrayList<Integer> hashes = new ArrayList<Integer>();

void setup() {
  size(600, 800);
  frameRate(updateRate);
  noStroke();

  initDisplay();

  initialize();
}

void draw() {
  background(backgroundColor);
  update();
  generateHash();
  show();

  if(debugging) {
    printWorld();
  }
}

void update() {
  int currentTime = millis();
  if (death) {
    if(currentTime > deathTime + deathDelay){
      initialize();
    }
  } else if (stasis) {
    if(currentTime > stasisTime + stasisDelay){
      initialize();
    }
  } else if (currentTime > initializationTime + maxRunTime) {
    initialize();
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

      if(world[x][y] == ALIVE){
        fill(pixelColor);
        rect(xPos, yPos, pWidth, pHeight);
      }
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
  death = false;
  stasis = false;
  initializationTime = millis();
  hashes.clear();
}

void generate() {
  boolean[][] newWorld = new boolean[worldWidth][worldHeight];
  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      int neighbors = 0;
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int xIndex = x + i;
          int yIndex = y + j;
          if (xIndex >= 0 && xIndex < worldWidth && yIndex >= 0 && yIndex < worldHeight) {
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
      }
    }
  }

  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      world[x][y] = newWorld[x][y];
    }
  }

  int currentHash = generateHash();

  if(currentHash == 0) {
    death = true;
    deathTime = millis();
  }

  if(hashes.contains(currentHash)) {
    stasis = true;
    stasisTime = millis();
  }

  hashes.add(0, currentHash);
}

void printWorld() {
  for (int y = 0; y < worldHeight; y++) {
    for (int x = 0; x < worldWidth; x++) {
      if(world[x][y] == ALIVE) {
        print("1");
      } else {
        print("0");
      }
      print(" ");
    }
    println();
  }
  println();
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

int generateHash() {
  int hash = 0;
  for (int x = 0; x < worldWidth; x++) {
    for (int y = 0; y < worldHeight; y++) {
      if(world[x][y] == ALIVE) {
        hash += (x * 50 + y);
      }
    }
  }
  if(debugging) {
    println(hash);
  }
  return hash;
}
