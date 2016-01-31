BufferedReader reader;
char nextChar;
int[] alphaCount = new int[26];
int[] alice = new int[5];
color[] pColor = new color[26];
int aliceCount = 0, charCount = 0,low,high;
PImage picture = createImage(400,600,RGB);
int screen = 0;
void setup() 
{
  countFrequencies();
}

void draw() 
{
  if(screen == 0) drawAlphaCount();
  else {background(0);}//drawBarGraph();
}
void mouseClicked() {
 if(screen == 0) screen = 1;
 else screen = 0;
}
void drawAlphaCount() {
 image(picture,0,0,width*2,height*2);
}
void drawBarGraph() {
  
}
void initialize() {
  for(int i = 0; i < 26; i++) {
    alphaCount[i] = 0; 
    
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
  pColor[24] = color(255,213,0);
  pColor[25] = color(255,213,213);
  alice[0]='a';
  alice[1]='l';
  alice[2]='i';
  alice[3]='c';
  alice[4]='e';
  
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
      picture.pixels[i++] = pColor[letter-97];
      
      //add if alice method
    }
    updatePixels();
  }
  catch (IOException e) {
    println("Error reading data...");
    e.printStackTrace();
  }
}