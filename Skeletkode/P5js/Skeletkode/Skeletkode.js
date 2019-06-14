// Connect to the local instance of fcserver
var WebSocketAddress = "ws://127.0.0.1:7890";

//Canvas
function setup() {
	createCanvas(600, 800);
	socketSetup(WebSocketAddress);
}

function draw() {
  background(0);
}
