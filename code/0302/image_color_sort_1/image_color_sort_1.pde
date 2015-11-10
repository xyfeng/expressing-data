PImage img;

void setup() {
  size(600, 600);
  noStroke();

  img = loadImage("01.jpeg");

  int tileCount = 60;
  float rectSize = width/ tileCount;

  for (int gridX=0; gridX < tileCount; gridX++ ) {
    for ( int gridY=0; gridY < tileCount; gridY++ ) {
      int px = (int)( gridX * rectSize );
      int py = (int)( gridY * rectSize );
      color pixel_color = img.get(px, py);
      fill(pixel_color);
      rect(gridX * rectSize, gridY * rectSize, rectSize, rectSize);
    }
  }
}

void draw() {
  //image(img, 0, 0);
}