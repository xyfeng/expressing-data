PImage img;
int drawMode = 1;
int tileCount;
float rectSize;

void setup() {
  size(600, 600);
  background(255);
  noStroke();
  //noCursor();
  strokeCap(SQUARE); 

  tileCount = 25;
  rectSize = width/ tileCount;

  img = loadImage("02.png");
}

void draw() {
  background(255);
  
  // factors to tweek the effect
  float mouseXFactor = map(mouseX, 0, width, 0.01, 2);
  float mouseYFactor = map(mouseY, 0, height, 0.01, 2);

  // loop through image pixels
  for (int gridX=0; gridX < tileCount; gridX++ ) {
    for ( int gridY=0; gridY < tileCount; gridY++ ) {
      // pixel index
      int px = (int)( gridX * rectSize );
      int py = (int)( gridY * rectSize );
      // load color of current pixel
      color c = img.get(px, py);
      int grayScale = getGrayScale(c);
      // find the pixel block position on the canvas
      float rectX = gridX * rectSize;
      float rectY = gridY * rectSize;
      // find the center position of the block on the canvas
      float centerX = rectX + rectSize/2;
      float centerY = rectY + rectSize/2;
      
      // switch drawings
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
        int pxNext = round(min(gridX + 1, tileCount - 1) * rectSize);
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