double[][] points;

void setup() {
  size(600, 400);
  pixelDensity(2);
  background(255);

  points = new double[height][width];
}

void draw() {
  background(255);
  //drawPoints();
  points[mouseY][mouseX] += random(30);
  drawHeatMap();
}

void drawHeatMap() {
  Heatmap hm = new Heatmap(points, 30);
  BufferedImage bi = hm.makeImage();
  PImage heatmap = new PImage(bi);
  image(heatmap, 0, 0);
}

void drawPoints() {
  noStroke();
  fill(0);
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      if (points[i][j] != 0) {
        ellipse(i, j, 4, 4);
      }
    }
  }
}