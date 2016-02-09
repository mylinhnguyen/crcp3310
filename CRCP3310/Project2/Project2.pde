//Monday: dashboard, eat data make arraylist of food
Walker walker;
Food food;
final float BOT_BARRIER = 750;
final float START_BARRIER = 200;
ArrayList<Food> buffet = new ArrayList<Food>();
void setup() {
  size(1600,1000);
  walker = new Walker(new PVector(width/2,height/2));
  for(int i = 0; i < 50;i++) buffet.add(new Food(new PVector(random(START_BARRIER,width),random(BOT_BARRIER)),(int)random(4)));
  //food = new Food(new PVector(random(50,width),random(height/1.5)));
}

void draw() {
  background(220);
  drawLayout();
  walker.walk();
  drawWalker();
  for(int i = buffet.size() -1; i >=0;i--) {
    buffet.get(i).drawFood();
    if(captured(buffet.get(i))) {
      walker.eat(buffet.get(i));
      buffet.remove(i);
      //////
    }
  }
  //food.drawFood();
  //if touching, remove food from arraylist starting from end
}
void drawLayout() {
  stroke(100,50,0);
  strokeWeight(4);
  line(200,0,200,BOT_BARRIER); //start line
  line(0,BOT_BARRIER,width,BOT_BARRIER);
}
void drawWalker() {
  stroke(250,180,50);
  fill(250,128,0);
  ellipse(walker.location.x, walker.location.y, 50, 50);
}
boolean captured(Food f) {
 return dist(walker.location.x,walker.location.y,f.location.x,f.location.y) < (width/2 + f.diameter * 2);
}
void mousePressed() {

}
class Food {
  PVector location;
  int diameter;
  color col;
  boolean eaten;
  
  public Food(PVector loc,int type) {
    this.location = loc;
    this.diameter = 20;
    this.eaten = false;
    if(type == 0) this.col = color(50,50,250);
    else if (type == 1) this.col = color(250,50,50);
    else if (type == 2) this.col = color(100,250,100);
    else if (type == 3) this.col = color(250,250,50);
    else this.col = color(250,50,250);
  }
  public void drawFood() {
    stroke(this.col);
    fill(this.col);
    ellipse(this.location.x,this.location.y,diameter,diameter);
  }
  
}

class Walker {
  final float NOISE_DELTA = 0.01;
  final int MAX_VELOCITY = 1;
  PVector location;
  PVector velocity; //changes location
  PVector acceleration; //changes velocity
  PVector tendency;
  float xOffset; 
  ArrayList<Food> stomach = new ArrayList<Food>();
  
  public Walker(PVector initialLocation) {
    this.location = initialLocation;
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,0);
    this.tendency = new PVector(1.4,0);
    xOffset = 0.0;
  }

  public void walk() {
    //*TWO_PI to be angle of circle
    this.acceleration = PVector.fromAngle(noise(xOffset) * TWO_PI ); //to generatre random angle using noise
    this.velocity.add(acceleration);
    this.velocity.add(tendency);
    this.location.add(velocity);
    this.velocity.limit(MAX_VELOCITY); 
    xOffset += NOISE_DELTA;
    if(this.location.y < 0) this.location.y = height;
    if (this.location.y > height) this.location.y = 0;
    if(this.location.x < 0) this.location.x = width;
    if(this.location.x > width) this.location.x = 0;
  }
  public void eat(Food f) {
    this.stomach.add(f);
  }
}