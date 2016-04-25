var destroyer;
var laser;
var ufo;
var testufo = [];
var img;


function setup() {
	createCanvas(800,500);
	destroyer = new Destroyer();
	laser = new Laser(this.position.x + size/2, this.position.y);
	img = loadImage("ufo.png");
	createUFOs(10);
}

function createUFOs(amount) {
	//testufo[i] = new UFO(createVector(100 + 100 * i, y), 30);
	var i = 0;
	for (var y = 100; y < height; y = y + 100) {
		for (var x = 100; x < width; x = x + 100) {
			testufo[i] = new UFO(createVector(x, y), 30);
			i++;
			if (i == amount)
				break;
		}
	}
}
function colision() {
	
}
function draw() {
	background(150);
	laser.move();
	destroyer.draw();
	laser.update(this.position.x + size/2);
	for (var i = 0; i < 5; i++) {
		testufo[i].draw();
		testufo[i].move();
	}
	if (keyIsDown(LEFT_ARROW)) {
		destroyer.move(-5);
	}
	else if (keyIsDown(RIGHT_ARROW)) {
		destroyer.move(5);
	}
	if (keyCode == UP_ARROW) {
		laser.pew();
	}
	else if (keyIsDown(UP_ARROW)) {
		laser.pew();
	}
}
function hit() {

	return false;
}

function play() {
	setup();
	createUFOs(10);
	draw();
}
///////////////////////////////////////////////////////
//Destroyer functions
function Destroyer() {
	position = createVector(width/2, height - 50);
	size = 30;
	value = 0;
}
//changes position of Destroyer and keeps within boundries
Destroyer.prototype.move = function move(value) {
	position.x += value;
	if (position.x < 0) 
		position.x = 0;
	else if (position.x > width - size)
		position.x = width - size;
}

Destroyer.prototype.draw = function draw() {
	stroke(0);
	fill(200,100,80);
	rect(position.x, position.y, size, size);
	laser.draw();
}
///////////////////////////////////////////////////////
//Laser functions
function Laser(x, y) {
	laser_position = createVector(x, y);
	reloadY = y;
	length = 10;
	pewpew = false;
}
//draws the laser
Laser.prototype.draw = function draw() {
	if (pewpew) {
		stroke(250,0,0);
		line(laser_position.x, laser_position.y, laser_position.x, laser_position.y + length);
	}
}
//changes the y position of the laser to create the pew-pew movement
Laser.prototype.move = function move() {
	if (pewpew) {
		laser_position.y -= 5;
		if (laser_position.y < -length) 
			laser.reset();
	}
}
Laser.prototype.update = function update(x) {
	if (!pewpew)
		laser_position.x = x;
}
//
Laser.prototype.pew = function pew() {
	pewpew = true;
}
//called to reset the laser beam
Laser.prototype.reset = function reset() {
	pewpew = false;
	laser_position.y = reloadY;
}
///////////////////////////////////////////////////////
//UFO functions
function UFO(pos, size) {
	this.position = pos;
	this.size = size;
	this.speed = 2;
}
//
UFO.prototype.draw = function draw() {
	stroke(0,200,0);
	fill(0,250,0);
	image(img, this.position.x, this.position.y);
	//ellipse(this.position.x, this.position.y, this.size, this.size);
}
//
UFO.prototype.move = function move() {
	this.position.x += this.speed;
	if (this.position.x < this.size) {
		this.speed *= -1;
		if(this.position.y > height/2)
			this.position.y -= 4;
		else this.position.y += 4;
	}
	else if (this.position.x > width - size) {
		this.speed *= -1;
		if(this.position.y > height/2)
			this.position.y -= 4;
		else this.position.y += 4;
	}
}
//
UFO.prototype.destroyed = function destroyed() {

}

play();