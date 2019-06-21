// Connect to the local instance of fcserver
var WebSocketAddress = "ws://127.0.0.1:7890";
var showPixelLocations = true;

//Canvas
function setup() {
	createCanvas(600, 800);
	socketSetup(WebSocketAddress);

	initDisplay();
}

function draw() {
  background(0);

	drawFrame();
}

function initDisplay() {
  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  var wGrid = 12;
  var hGrid = 4;
  var wSpacing = width / 12;
  var hSpacing = height / 16;
  var xPos = width / 2;

  for (var i = 0; i < 4; i++) {
    var yPos = ((hGrid / 2) * hSpacing) + (i * hGrid * hSpacing);

    // Map an 12x16 grid of LEDs to the center of the window, scaled to take up most of the space
    ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false);
    ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false);
    ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false);
    ledGrid(i * 64, wGrid, hGrid, xPos, yPos, wSpacing, hSpacing, 0, false);
  }
}
