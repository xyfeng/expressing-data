// reference
// https://processing.org/reference/point_.html
// https://processing.org/reference/line_.html
// https://processing.org/reference/strokeCap_.html
// https://processing.org/reference/arc_.html
// https://www.processing.org/tutorials/curves/

void setup() {
  size(800, 400);
  background(255);

  // point
  stroke(200, 0, 0);
  point(10, 10);
  strokeWeight(10);
  point(10, 20);

  // line
  strokeWeight(1);
  stroke(0, 200, 0);
  line(60, 10, 240, 10);
  strokeWeight(8);
  line(60, 24, 240, 24);
  strokeWeight(8);
  strokeCap(SQUARE);
  line(60, 40, 240, 40);
  
  // triangle
  stroke(0);
  strokeWeight(4);
  triangle(200, 275, 358, 320, 286, 375);
  
  // rect
  rect(50, 100, 100, 100);
  
  // quad
  quad(238, 131, 286, 120, 269, 163, 230, 176);
  
  // ellipse
  fill(240);
  ellipse(400, 46, 55, 55);

  // arc
  noFill();
  arc(600, 35, 50, 50, -PI, 0);  // upper half of circle
  fill(240);
  arc(600, 105, 100, 50, PI / 2, 3 * PI / 2); // 180 degrees
  
  // curve
  noFill();
  beginShape();
  curveVertex(400, 340); // the first control point
  curveVertex(400, 340); // is also the start point of curve
  curveVertex(500, 360);
  curveVertex(600, 300);
  curveVertex(640, 320);
  curveVertex(700, 350); // the last point of curve
  curveVertex(700, 350); // is also the last control point
  endShape();
}