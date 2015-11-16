// Reference
// Video: https://viwmeo.com/63635193
// 1280 x 720

import processing.video.*;
Movie myMovie;

int rectWidth;
int columnCount;
int columnIndex;

void setup() {
  size(1280, 720);
  background(255);
  noStroke();

  myMovie = new Movie(this, "shanghai.mp4");
  myMovie.loop();
  
  columnCount = 60;
  columnIndex = 0;
  rectWidth = ceil((float)width / columnCount);
}

void draw() {
  if (myMovie.available() && columnIndex < columnCount) {
    // jump to the right position
    float pos = map(columnIndex, 0, columnCount, 0, myMovie.duration());
    myMovie.jump(pos);
    myMovie.read();
    //image(myMovie, 0, 0);
    int columnX = columnIndex * rectWidth;
    int columnY = 0;
    int columnWidth = rectWidth;
    int columnHeight = height;
    copy(myMovie, columnX, columnY, columnWidth, columnHeight,columnX, columnY, columnWidth, columnHeight);
    columnIndex ++;
  }
}