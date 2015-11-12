// Reference
// Video: https://viwmeo.com/63635193
// 1280 x 720

import processing.video.*;
Movie myMovie;

int columnCount;
int rectWidth;
int columnIndex;

void setup() {
  size(1280, 720);
  background(255);
  noStroke();

  columnCount = 20;
  columnIndex = 0;
  rectWidth = ceil(width / columnCount);

  myMovie = new Movie(this, "shanghai.mp4");
  myMovie.loop();
}

void draw() {
  if (myMovie.available() && columnIndex < columnCount) {
    float pos = map(columnIndex, 0, columnCount, 0, myMovie.duration());
    myMovie.jump(pos);
    myMovie.read();
    int posX = rectWidth * columnIndex;
    int posY = 0;
    int w = rectWidth;
    int h = height;
    copy(myMovie, posX, posY, w, h, posX, posY, w, h);
    columnIndex++;
  }
  else if(columnIndex == columnCount) {
    myMovie.stop();
  }
}