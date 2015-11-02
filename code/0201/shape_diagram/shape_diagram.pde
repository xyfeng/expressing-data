// reference
// https://processing.org/reference/point_.html
// https://processing.org/reference/line_.html
// https://processing.org/reference/strokeCap_.html
// https://processing.org/reference/arc_.html
// https://www.processing.org/tutorials/curves/


void setup() {
  size(800, 400);
  background(255);

  // generate data
  int[] values = new int[20];
  for (int i=0; i<20; i++) {
    values[i] = (int)random(10, 60);
  }

  // using line to draw
  stroke(0);
  strokeWeight(1);
  // x axis
  line(10, 100, 250, 100);
  // y axis
  line(10, 10, 10, 100);
  // draw line
  int offsetX = 15;
  int horizontal_distance = 12;
  stroke(20, 180, 60);
  for ( int i=0; i<19; i++) {
    int x1 = i*horizontal_distance;
    int x2 = (i+1)*horizontal_distance;
    int y1 = 100 - values[i];
    int y2 = 100 - values[i+1];
    line(offsetX+x1, y1, offsetX+x2, y2);
  }

  // using spline curve
  stroke(0);
  // x axis
  line(10, 300, 250, 300);
  // y axis
  line(10, 210, 10, 300);
  // draw curve
  stroke(20, 180, 60);
  beginShape();
  curveVertex(offsetX, 300); // first point as control point
  for ( int i=0; i<20; i++) {
    int x1 = i*horizontal_distance;
    int y1 = 300-values[i];
    curveVertex(offsetX+x1, y1);
  }
  curveVertex(offsetX + 20*horizontal_distance, 300); // last point as control point
  endShape();

  // using triangle
  stroke(0);
  strokeWeight(1);
  // x axis
  line(300, 100, 550, 100);
  // y axis
  line(300, 10, 300, 100);
  fill(20, 180, 60);
  noStroke();
  offsetX = 305;
  for ( int i=0; i<19; i++) {
    int x1 = offsetX+i*horizontal_distance;
    int y1 = 100;
    int x2 = offsetX +(i)*horizontal_distance + horizontal_distance/2;
    int y2 = 100-values[i];
    int x3 = offsetX+(i+1)*horizontal_distance;
    int y3 = 100;
    triangle(x1, y1, x2, y2, x3, y3);
  }

  // using rect to draw
  stroke(0);
  strokeWeight(1);
  // x axis
  line(300, 300, 550, 300);
  // y axis
  line(300, 210, 300, 300);
  noStroke();
  fill(20, 180, 60);
  for ( int i=0; i<20; i++) {
    int x1 = offsetX+i*horizontal_distance;
    int y1 = 300-values[i];
    int w1 = 10;
    int h1 = values[i];
    rect(x1, y1, w1, h1);
  }

  // using arc to show 20 out of 60
  // draw background gray circle
  noFill();
  strokeWeight(10);
  strokeCap(ROUND);
  stroke(240);
  ellipse(680, 180, 100, 100);
  // draw arc
  stroke(20, 180, 60);
  // -PI/2 to set origin from top center
  arc(680, 180, 100, 100, -PI/2, -PI/2 + PI * 2 * (20/60.0));
}