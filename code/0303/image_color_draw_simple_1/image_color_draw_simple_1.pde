PImage img;
int drawMode = 6;
int tileCount;
int rectSize;

void setup() {
  size(600, 230);
  rectSize = 30;
  tileCount = 600 / rectSize;

  background(255);
  noStroke();
  //noCursor();
  strokeCap(SQUARE); 

  img = loadImage("01.jpeg");
}

void draw() {
  background(255);
  // drawing reference rectangle
  fill(240, 0, 0, 30);
  noStroke();
  rect(0, 0, width, 100);
  rect(0, 130, width, 100);

  float mouseXFactor = map(mouseX, 0, width, 0.01, 2);
  float mouseYFactor = map(mouseY, 0, height, 0.01, 2);

  for (int gridX=0; gridX < tileCount; gridX++) {
    // get pixel position in the canvas 
    int px = gridX * rectSize;
    int pxNext = min(gridX + 1, tileCount - 1) * rectSize;
    int py = 300; // pick a middle row;
    color c = img.get(px, py);
    color cNext = img.get(pxNext, py);
    // calculate the rectangle drawing area, top left corner of the block
    float rectX = gridX * rectSize;  
    float rectY = 100;
    // find the center position of the block on the canvas
    float centerX = rectX + rectSize/2;
    float centerY = 100 + rectSize/2; // 15

    float grayScale = getGrayScale(c);
    float grayScaleNext = getGrayScale(cNext);

    //draw the pixal out
    fill(c, 120);
    noStroke();
    rect(rectX, rectY, rectSize, rectSize);

    if (drawMode == 1) {
      stroke(0);
      if ( grayScale < 127) {
        strokeWeight(10 * mouseXFactor);
        line(rectX, rectY, rectX+rectSize, rectY+rectSize);
      } else {
        strokeWeight(1);
        line(rectX+rectSize, rectY, rectX, rectY+rectSize);
      }
    } else if (drawMode == 2) {
      stroke(0);
      float s = map(grayScale, 0, 255, 10, 0);
      strokeWeight(s * mouseXFactor);
      line(rectX, rectY, rectX+rectSize, rectY+rectSize);
    } else if (drawMode == 3) {
      stroke(0);
      float s = map(grayScale, 0, 255, 10, 0);
      float r = map(grayScale, 0, 255, 0, PI*2) * mouseYFactor;
      strokeWeight(s * mouseXFactor);
      pushMatrix();
      translate(rectX, rectY);
      rotate(r);
      line(0, 0, rectSize, 0);
      popMatrix();
    } else if (drawMode == 4) {
      stroke(c);
      float s = map(grayScale, 0, 255, 10, 0);
      strokeWeight(s * mouseXFactor);

      float offset = map(grayScale, 0, 255, 30, 0) * mouseYFactor;
      float offsetNext = map(grayScaleNext, 0, 255, 30, 0) * mouseYFactor;

      line(rectX-offset, rectY+offset, rectX+rectSize - offsetNext, rectY + offsetNext);
    } else if (drawMode == 5) {
      fill(c);
      noStroke();
      float ellipseSize = map(grayScale, 0, 255, rectSize, 0) * mouseXFactor;
      ellipse(centerX, centerY, ellipseSize, ellipseSize);
    } else if (drawMode == 6) {
      fill(c);
      noStroke();
      float ellipseSize = rectSize * 0.9;
      ellipse(centerX, centerY, ellipseSize, ellipseSize);
      fill(255);
      float irisSize = map(grayScale, 0, 255, rectSize*0.2, rectSize*0.5);
      float irisAngle = map(hue(c), 0, 255, 0, PI*2) * mouseYFactor;
      float irisRadius = map(saturation(c), 0, 255, 0, ellipseSize/2 - irisSize/2) * mouseXFactor;
      float irisX = cos(irisAngle) * irisRadius;
      float irisY = sin(irisAngle) * irisRadius;
      ellipse(centerX + irisX, centerY + irisY, irisSize, irisSize);
    }
  }
}

// get grasy scale from 0 to 255
int getGrayScale(color oneColor) {
  return round(red(oneColor)*0.213 + green(oneColor)*0.715 + blue(oneColor)*0.072);
}

void keyPressed() {
  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;
  if (key == '3') drawMode = 3;
  if (key == '4') drawMode = 4;
  if (key == '5') drawMode = 5;
  if (key == '6') drawMode = 6;
}