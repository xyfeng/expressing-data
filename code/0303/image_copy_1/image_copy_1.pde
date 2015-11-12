// Reference
// Video: https://viwmeo.com/63635193
// 1280 x 720

import processing.video.*;
Movie myMovie;

void setup() {
  size(1280, 720);
  background(255);
  noStroke();

  myMovie = new Movie(this, "shanghai.mp4");
  myMovie.loop();
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
    image(myMovie, 0, 0);
  }
}