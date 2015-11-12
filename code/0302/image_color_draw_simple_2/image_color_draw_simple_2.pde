PImage img;
int drawMode = 1;
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
  // drawing reference rect
  fill(240, 0, 0, 30);
  noStroke();
  rect(0, 0, width, 100);
  rect(0, 130, width, 100);

  // add mouseFactor
  float mouseXFactor = map(mouseX, 0, width, 0.01, 2);
  float mouseYFactor = map(mouseY, 0, height, 0.01, 2);

  for (int gridX=0; gridX < tileCount; gridX++) {
    // get pixel position in the canvas 
    int px = gridX * rectSize;  
    int py = 300; // pick a middle row;
    color c = img.get(px, py);
    // calculate the rectangle drawing area, top left corner of the block
    float rectX = gridX * rectSize;  
    float rectY = 100;
    // find the center position of the block on the canvas
    float centerX = rectX + rectSize/2;
    float centerY = 100 + rectSize/2; // 15

    //draw the pixal out as a reference
    fill(c, 127);
    noStroke();
    rect(rectX, rectY, rectSize, rectSize);

    // grayscale to line
    int grayScale = getGrayScale(c);
    if (drawMode == 1) {
      noFill();
      stroke(0);
      if (grayScale < 127)
      {
        strokeWeight(5 * mouseXFactor);
        line(rectX, rectY, rectX+rectSize, rectY+rectSize);
      } else {
        strokeWeight(1);
        line(rectX+rectSize, rectY, rectX, rectY+rectSize);
      }
    } else if (drawMode == 2) {
      noFill();
      stroke(0);
      float s = map(grayScale, 0, 255, 8, 0.1);
      strokeWeight(s * mouseXFactor);
      line(rectX, rectY, rectX+rectSize, rectY+rectSize);
    } else if (drawMode == 3) {
      noFill();
      stroke(0);
      float s = map(grayScale, 0, 255, 8, 0.1);
      float p = map(grayScale, 0, 255, 0, PI);
      strokeWeight(s * mouseXFactor);
      pushMatrix();
      translate(rectX, rectY);
      rotate(p * mouseYFactor);
      line(0, 0, rectSize, 0);
      popMatrix();
    } else if (drawMode == 4) {
      noFill();
      stroke(c);
      float s = map(grayScale, 0, 255, 8, 0.1);
      strokeWeight(s * mouseXFactor);
      int pxNext = min(gridX + 1, tileCount - 1) * rectSize;
      color cNext = img.get(pxNext, py);
      int grayScaleNext = getGrayScale(cNext);
      float offsetPos = map(grayScale, 0, 255, 30, 0) * mouseYFactor;
      float offsetPosNext = map(grayScaleNext, 0, 255, 30, 0) * mouseYFactor;
      line(rectX - offsetPos, rectY + offsetPos, rectX + rectSize - offsetPosNext, rectY + offsetPosNext);
    } else if (drawMode == 5) {
      fill(c);
      noStroke();
      float ellipseSize = map(grayScale, 0, 255, rectSize, 0) * mouseXFactor;
      ellipse(centerX, centerY, ellipseSize, ellipseSize);
    } else if (drawMode == 6) {
      fill(c);
      noStroke();
      float ellipseSize = rectSize*0.9;
      ellipse(centerX, centerY, ellipseSize, ellipseSize);
      //draw iris
      fill(255);
      float irisSize = map(grayScale, 0, 255, rectSize*0.5, rectSize*0.2);
      float irisRadius = map(hue(c), 0, 255, (ellipseSize - irisSize)/2, 0);
      float irisAngle = map(saturation(c), 0, 255, PI * 2, 0) * mouseXFactor;
      float irisX = cos(irisAngle) * irisRadius;
      float irisY = sin(irisAngle) * irisRadius;
      ellipse(centerX + irisX, centerY + irisY, irisSize, irisSize);
    }
  }
}

// get grasy scale
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