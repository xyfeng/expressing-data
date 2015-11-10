import generativedesign.*;

PImage img;
color[] colors;

int tileCount;
float rectSize;

String sortMode = null;

void setup() {
  size(600, 600);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);

  img = loadImage("01.jpeg");
}

void draw() {
  tileCount = (int)map(mouseX, 0, width, 1, width/10);
  rectSize = width/ (float)tileCount;
  loadColor();
  sortColor();
  drawColor();
}

void loadColor() {
  int index = 0;
  colors = new color[tileCount * tileCount];
  for ( int gridY=0; gridY < tileCount; gridY++ ) {
    for (int gridX=0; gridX < tileCount; gridX++ ) {
      int px = (int)( gridX * rectSize );
      int py = (int)( gridY * rectSize );
      colors[index] = img.get(px, py);
      index ++;
    }
  }
}

void sortColor() {
  // sort colors
  if (sortMode != null) colors = GenerativeDesign.sortColors(this, colors, sortMode);
}

void drawColor() {
  int index = 0;
  for ( int gridY=0; gridY < tileCount; gridY++ ) {
    for (int gridX=0; gridX < tileCount; gridX++ ) {
      fill(colors[index]);
      rect(gridX * rectSize, gridY * rectSize, rectSize, rectSize);
      index ++;
    }
  }
}


void keyReleased() {
  // change sorting mode
  if (key == '1') {
    sortMode = null;
  }
  if (key == '2') {
    sortMode = GenerativeDesign.HUE;
  }
  if (key == '3') {
    sortMode = GenerativeDesign.SATURATION;
  }
  if (key == '4') {
    sortMode = GenerativeDesign.BRIGHTNESS;
  }
  if (key == '5') {
    sortMode = GenerativeDesign.GRAYSCALE;
  }
  
  // change images
  if (key == 'a') {
    img = loadImage("01.jpeg");
  }
  if (key == 'b') {
    img = loadImage("02.jpeg");
  }
}