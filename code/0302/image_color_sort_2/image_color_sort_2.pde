import generativedesign.*;

PImage img;
color[] colors;

int tileCount = 60;
float rectSize;

void setup() {
  size(600, 600);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);

  img = loadImage("01.jpeg");
  rectSize = width/ tileCount;

  loadColor();
  sortColor();
  drawColor();
}

void draw() {
  //image(img, 0, 0);
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
  colors = GenerativeDesign.sortColors(this, colors, GenerativeDesign.GRAYSCALE);
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