var destroyer;
var ufo;
var enemy = [];
var number;

function setup() {
	createCanvas(800,500);
	destroyer = new Destroyer();
	createUFOs(5);
}

function createUFOs(amount) {
	number = amount;
	var i = 0;
	for (var y = 100; y < height; y = y + 50) {
		for (var x = 100; x < width; x = x + 50) {
			enemy[i] = new UFO(createVector(x, y), 30);
			i++;
			if (i == amount)
				return;
		}
	}
}

function collision(enemy) {
	for (var i = 0; i < destroyer.ammo; i++) {
		if (enemy.)
	}
}

function draw() {
	background(150);
	destroyer.draw();
	for (var i = 0; i < number; i++) {
		enemy[i].draw();
		enemy[i].move();
		collision(testufo[i]);
	}
	if (keyIsDown(LEFT_ARROW)) {
		destroyer.move(-5);
	}
	else if (keyIsDown(RIGHT_ARROW)) {
		destroyer.move(5);
	}
	if (keyCode == UP_ARROW) {
		destroyer.pew();
	}
	else if (keyIsDown(UP_ARROW)) {
		destroyer.pew();
	}
	
}

///////////////////////////////////////////////////////
//Destroyer functions
function Destroyer() {
	position = createVector(width/2, height - 50);
	size = 30;
	laser = [];
	ammo = 3;
	laser[0] = new Laser(position.x, position.y);
}
//changes position of Destroyer and keeps within boundries
Destroyer.prototype.move = function move(value) {
	if (position.x < 0) 
		position.x = 0;
	else if (position.x > width - size)
		position.x = width - size;
	position.x += value;
}

Destroyer.prototype.draw = function draw() {
	stroke(0);
	fill(200,100,80);
	rect(position.x, position.y, size, size);
	laser[0].draw();
	laser[0].move();
}

Destroyer.prototype.pew = function pew() {
	//check if each laser is ready to be fired
	laser[0].fire(position.x);
}
///////////////////////////////////////////////////////
//Laser functions
function Laser(x, y) {
	this.laser_position = createVector(x, y);
	reloadY = y;
	length = 10;
	this.ready = false;
}

Laser.prototype.draw = function draw() {
	if (this.ready) {
		strokeWeight(3);
		stroke(200,0,0);
		line(this.laser_position.x, this.laser_position.y, this.laser_position.x, this.laser_position.y + length);
	}
	else {

	}
}

Laser.prototype.move = function move() {
	if (this.ready) {
		this.laser_position.y -= 5;
		if (this.laser_position.y < 0) {
			this.ready = false;
			this.laser_position.y = reloadY;
		}
	}
	else {}
		//this.laser_position.y = reloadY;
}

Laser.prototype.fire = function fire(x) {
	if (!this.ready) {
		this.laser_position.x = x;
		this.ready = true;
	}
}

///////////////////////////////////////////////////////
//UFO functions
function UFO(pos, size) {
	this.position = pos;
	this.size = size;
	this.speed = 2;
	this.isDestroyed = false;
}

UFO.prototype.draw = function draw() {
	if (!this.isDestroyed) {
		stroke(0,200,0);
		fill(0,250,0);
		ellipse(this.position.x, this.position.y, this.size, this.size);
	}	
}

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

UFO.prototype.destroyed = function destroyed() {
	this.isDestroyed = true;
}