OPC opc;

final boolean ALIVE = true;
final boolean DEAD = false;

color pixelColor = color(150, 150, 0);
color backgroundColor = color(0);

boolean debugging = false;

int updateRate = 5;
int maxRunTime = 30000;
int initializationTime;
int deathDelay = 2000;
int stasisDelay = 4000;
int deathTime;
int stasisTime;
boolean death = false;
boolean stasis = false;

int worldWidth = 12;
int worldHeight = 15;
boolean[][] world = new boolean[worldWidth][worldHeight];


void setup() {
  size(600, 800);
  frameRate(updateRate);
  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map an 12x15 grid of LEDs to the center of the window, scaled to take up most of the space
  opc.ledGrid(0 * 64, 12, 4, width * 1/2, height * 1/5, width/13, height/17, 0, false, false);
  opc.ledGrid(1 * 64, 12, 4, width * 1/2, height * 2/5, width/13, height/17, 0, false, false);
  opc.ledGrid(2 * 64, 12, 4, width * 1/2, height * 3/5, width/13, height/17, 0, false, false);
  opc.ledGrid(3 * 64, 12, 4, width * 1/2, height * 4/5, width/13, height/17, 0, false, false);

  generate();
}

void draw() {
  background(backgroundColor);
  update();
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

      if(world[x][y] == true){
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
}

void generate() {
  boolean[][] newWorld = new boolean[worldWidth][worldHeight];
  int stasisCount = 0;
  int liveDots = 0;
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
        stasisCount++;
      }
      if(world[x][y] == ALIVE) {
        liveDots++;
      }
    }
  }

  if(liveDots == 0) {
    death = true;
    deathTime = millis();
  }
  if(stasisCount == worldWidth * worldHeight) {
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
