// Connect to the local instance of fcserver
var WebSocketAddress = "ws://127.0.0.1:7890";

//Canvas
function setup() {
	createCanvas(600, 800);
	socketSetup(WebSocketAddress);

	initDisplay();
}

function draw() {
  background(0);
}

function initDisplay() {
  // Map an 12x15 grid of LEDs to the center of the window, scaled to take up most of the space
  opc.ledGrid(0 * 64, 12, 4, width * 1/2, height * 1/5, width/13, height/17, 0, false, false);
  opc.ledGrid(1 * 64, 12, 4, width * 1/2, height * 2/5, width/13, height/17, 0, false, false);
  opc.ledGrid(2 * 64, 12, 4, width * 1/2, height * 3/5, width/13, height/17, 0, false, false);
  opc.ledGrid(3 * 64, 12, 4, width * 1/2, height * 4/5, width/13, height/17, 0, false, false);
}
