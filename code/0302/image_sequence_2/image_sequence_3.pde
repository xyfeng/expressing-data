// Reference
// Video: https://vimeo.com/63635193
// 1280 x 720

import generativedesign.*;
import processing.video.*;
int tileCount;
float rectSize;

Movie myMovie;
color[] colors;
String sortMode = null;

void setup() {
  size(720, 720);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);

  myMovie = new Movie(this, "shanghai.mp4");
  myMovie.loop();
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
      int px = (int)( gridX * rectSize ) + (1280 - 720)/2;
      int py = (int)( gridY * rectSize );
      colors[index] = myMovie.get(px, py);
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
}

void movieEvent(Movie m) {
  m.read();
}