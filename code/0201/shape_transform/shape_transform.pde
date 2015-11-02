// reference
// https://processing.org/reference/pushMatrix_.html
// https://processing.org/reference/rotate_.html
// https://processing.org/reference/translate_.html

void setup() {
  size(400, 400);
  noStroke();
  background(255);

  // generate data
  int[] values = new int[80];
  for (int i=0; i<80; i++) {
    values[i] = (int)random(120, 180);
  }

  // draw data in rotated bar chart
  fill(255,39,193, 60);
  for (int i=0; i<values.length; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(2 * PI / values.length * i);
    // draw rect, need to offset the x origin
    rect(-3, -values[i], 6, values[i]);
    popMatrix();
  }
  
  // draw an ellipse on top to cover
  fill(255);
  ellipse(200, 200, 200, 200);
}