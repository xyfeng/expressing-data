// Reference
// Video: https://vimeo.com/63635193
// 1280 x 720

import processing.video.*;
int tileCount;
float rectSize;
int drawMode = 1;

Movie myMovie;

void setup() {
  size(720, 720);
  background(255);
  noStroke();

  tileCount = 30;
  rectSize = width/ tileCount;

  myMovie = new Movie(this, "cart.mp4");
  myMovie.loop();
}

void draw() {
  background(255);

  float mouseXFactor = map(mouseX, 0, width, 0.05, 1);
  float mouseYFactor = map(mouseY, 0, width, 0.05, 1);

  for (int gridX=0; gridX < tileCount; gridX++ ) {
    for ( int gridY=0; gridY < tileCount; gridY++ ) {
      int px = (int)( gridX * rectSize );
      int py = (int)( gridY * rectSize );
      color c = myMovie.get(px, py);
      int grayScale = getGrayScale(c);
      float rectX = gridX * rectSize;
      float rectY = gridY * rectSize;
      float centerX = rectX + rectSize/2;
      float centerY = rectY + rectSize/2;
      
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
        color cNext = myMovie.get(pxNext, py);
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

void movieEvent(Movie m) {
  m.read();
}