var destroyer;
var ufo;
var enemy = [];
var number;
var enemy_left;
var end_screen = false;

function setup() {
	createCanvas(800,500);
	destroyer = new Destroyer();
	createUFOs(5);
}

function createUFOs(amount) {
	enemy_left = number = amount;
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

function draw() {
	if (!end_screen) {
		background(150);
		destroyer.draw();
		for (var i = 0; i < number; i++) {
			enemy[i].draw();
			enemy[i].move();
		}
		if (keyIsDown(LEFT_ARROW)) {
			destroyer.move(-5);
		}
		else if (keyIsDown(RIGHT_ARROW)) {
			destroyer.move(5);
		}
		if (keyIsDown(UP_ARROW)) {
			destroyer.pew();
		}	
		if (enemy_left == 0)
			end_screen = true;
	}
	else {
		//draw end screen here
		background(0);
	}
}

function collide(laser) {
	for (var i = 0; i < number; i++) {
		if (enemy[i].position.x - enemy[i].size/2 <= laser.laser_position.x  && laser.laser_position.x <= enemy[i].position.x + enemy[i].size/2 &&
				enemy[i].position.y - enemy[i].size/2 <= laser.laser_position.y && laser.laser_position.y <= enemy[i].position.y + enemy[i].size/2 ||
				enemy[i].position.y - enemy[i].size <= laser.laser_position.y + laser.length && laser.laser_position.y + laser.length <= enemy[i].position.y + enemy[i].size/2) {
					if (!enemy[i].isDestroyed) {
						enemy_left-=1;
					}
					enemy[i].destroyed();
		}			
	}
}
///////////////////////////////////////////////////////
//Destroyer functions
function Destroyer() {
	position = createVector(width/2, height - 50);
	size = 30;
	ammo = new Ammo(10);
	fire_rate = 50;
	counter = 0;
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
	noStroke();
	fill(200,100,80);
	rect(position.x, position.y, size, size);
	counter++;
	ammo.draw();
}

Destroyer.prototype.pew = function pew() {
	//check if each laser is ready to be fired
	if (counter > fire_rate) {
		ammo.fire(position.x, position.y);
		counter = 0;
	}
}
///////////////////////////////////////////////////////
//Laser functions
function Laser(x, y) {
	this.laser_position = createVector(x, y);
	reloadY = y;
	length = 10;
	this.speed = 6;
	this.ready = false;
}

Laser.prototype.draw = function draw() {
	if (this.ready) {
		strokeWeight(3);
		stroke(200,0,0);
		line(this.laser_position.x, this.laser_position.y, this.laser_position.x, this.laser_position.y + length);
	}
}

Laser.prototype.move = function move() {
	if (this.ready) {
		this.laser_position.y -= this.speed;
		if (this.laser_position.y < 0) {
			this.laser_position.y = reloadY;
			this.ready = false;
		}
	}
}

Laser.prototype.release = function release(bool, newX, newY) {
	this.laser_position = createVector(newX, newY);
	this.ready = bool;
}
///////////////////////////////////////////////////////
var Ammo = function(size) {
	this.pool = [];
	this.counter = 0;
	this.size = size;
	for (var i = 0; i < size; i++)
		this.pool[i] = new Laser(position.x, position.y);
}

Ammo.prototype.fire = function fire(x, y) {
	this.pool[this.counter].release(true, x, y);
	this.counter++;
	if (this.counter >= this.size)
		this.counter = 0;
}

Ammo.prototype.draw = function draw() {
	for (var i = 0; i < this.size; i++) {
		this.pool[i].draw();
		this.pool[i].move();
		collide(this.pool[i]);
	}
}

///////////////////////////////////////////////////////
//UFO functions
function UFO(pos, size) {
	this.position = pos;
	this.size = size;
	this.speed = 4;
	this.isDestroyed = false;
}

UFO.prototype.draw = function draw() {
	if (!this.isDestroyed) {
		noStroke();
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
