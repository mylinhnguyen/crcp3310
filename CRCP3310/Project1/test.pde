/*
My-Linh Nguyen
Project 1: Parsing and Visualizing Unstructured Data
Program reads in a text file and:
  -counts how many times each alpha character appears
  -counts how many times the word "Alice" appears
  -counts how many alpha characters there are in the file
  -creates 2 different visuals that can switch by clicking
    1) pixel image that color codes each letter and each "Alice"
    2) bar graph that displays the numerical information about the text
*/
BufferedReader reader;
int[] alphaCount = new int[26]; //counts how many times each letter appears
char[] alice = new char[5]; //helper array to find the word "alice"
String check;
color[] pColor = new color[26]; //creates color for each letter
int aliceCount = 0, charCount = 0, low, high, cursor = 0; //counts how many times "alice" appears, counts how many characters are in the text, variable for minimun and maximum
PImage picture = createImage(500,400,RGB);
PGraphics barG;
int screen = 0; //to alternate between screens
void setup() 
{
  size(1100,800);
  countFrequencies();
  prepareBarGraph();
}

void draw() 
{
  if(screen == 0) drawAlphaCount();
  else drawBarGraph();
}
void mouseClicked() {
 if(screen == 0) screen = 1;
 else screen = 0;
}

void drawAlphaCount() {
  background(240);
  image(picture,0,0,width,height);
}

void drawBarGraph() {
  image(barG,0,0);
}

void prepareBarGraph() {
  barG = createGraphics(1100,850);
  barG.beginDraw();
  barG.background(50);
  int letter;
  low = findMin();
  high = findMax();
  int barHeight = barG.height-75;
  for(int i = 0; i < alphaCount.length;i++) {  
    letter = 65+i;
    barG.fill(pColor[i],255);
    barG.stroke(pColor[i]);
    if(i == high) {
      barG.textSize(30);
      barG.text((char)letter,10,(barHeight/26)*i+23);
      barG.text(alphaCount[i],barG.width-100,(barHeight/26)*i+25);
      barG.fill(pColor[i],255);
      barG.rect(40,(barHeight/26)*i, map(alphaCount[i],0,alphaCount[high],0,barG.width-150), barHeight/26);
    }
    else if(i == low) {
      barG.textSize(30);
      barG.text((char)letter,10,(barHeight/26)*i+23);
      barG.text(alphaCount[i],barG.width-100,(barHeight/26)*i+25);
      barG.fill(pColor[i],255);
      barG.rect(40,(barHeight/26)*i, map(alphaCount[i],0,alphaCount[high],0,barG.width-150), barHeight/26);
    }
    else {
      barG.textSize(15);
      barG.text((char)letter,10,(barHeight/26)*i+20);
      barG.textSize(20);
      barG.text(alphaCount[i],barG.width-100,(barHeight/26)*i+23);
      barG.fill(pColor[i],100);
      barG.rect(40,(barHeight/26)*i, map(alphaCount[i],0,alphaCount[high],0,barG.width-150), barHeight/26);
    } 
  }
  barG.fill(255);
  barG.text("Number of characters: "+ charCount + "-------" + "Number of 'Alice': " + aliceCount,20,barHeight+10);
  barG.endDraw();  
}

void initialize() {
  for(int i = 0; i < 26; i++) {
    alphaCount[i] = 0; 
  } 
  for(int j = 0; j < 5; j++) {
    alice[j] = ' '; 
  }
  pColor[0] = color(255,0,0);
  pColor[1] = color(255,155,153);
  pColor[2] = color(255,128,0);
  pColor[3] = color(255,204,153);
  pColor[4] = color(255,255,0);
  pColor[5] = color(255,255,153);
  pColor[6] = color(128,255,0);
  pColor[7] = color(204,255,153);
  pColor[8] = color(0,255,0);
  pColor[9] = color(153,255,153);
  pColor[10] = color(0,255,153);
  pColor[11] = color(153,255,204);
  pColor[12] = color(0,255,255);
  pColor[13] = color(153,255,255);
  pColor[14] = color(0,128,255);
  pColor[15] = color(153,204,255);
  pColor[16] = color(0,0,255);
  pColor[17] = color(153,153,255);
  pColor[18] = color(128,0,255);
  pColor[19] = color(204,153,255);
  pColor[20] = color(255,0,255);
  pColor[21] = color(255,153,255);
  pColor[22] = color(255,0,127);
  pColor[23] = color(255,153,204);
  pColor[24] = color(48,40,0);
  pColor[25] = color(48,40,40);
  
}

int findMin() {
  int min = alphaCount[0];
  int loc = 0;
  for(int i = 1; i < alphaCount.length;i++) {
    if(alphaCount[i] < min) {
      min = alphaCount[i];
      loc = i; 
    }
  }
  return loc;
}
int findMax() {
  int max = alphaCount[0];
  int loc = 0;
  for(int i = 1; i < alphaCount.length;i++) {
    if(alphaCount[i] > max) {
      max = alphaCount[i];
      loc = i; 
    }
  }
  return loc;
}
void isAlice(char nextInput,int i) {
  if(cursor > 4) {
    alice[0] = alice[1];
    alice[1] = alice[2];
    alice[2] = alice[3];
    alice[3] = alice[4];
    alice[4] = nextInput;
    if(alice[0] == 'a') {
      check = new String(alice);
      if(check.equals("alice"))
      aliceCount++;
      highlightAlice(i);
    }
  }
  else alice[cursor++] = nextInput;
  
}
void highlightAlice(int i) {
  for(int h = 5;h > 0; h--) 
  picture.pixels[i-h] = color(255,213,0,160); 
}
void countFrequencies() {
  initialize();
  int i = 0;
  reader = createReader("alice.txt");
  loadPixels();
  try {
    int character;
    while((character = reader.read()) != -1) {
      if(!Character.isAlphabetic(character)) {
        picture.pixels[i++] = color(0,0,0);
        continue;
      }
      charCount++;
      char letter = (char)Character.toLowerCase(character);
      alphaCount[letter-97]++;
      picture.pixels[i++] = color(pColor[letter-97],200);
      isAlice(letter,i);
    }
    updatePixels();
  }
  catch (IOException e) {
    println("Error reading data...");
    e.printStackTrace();
  }
}