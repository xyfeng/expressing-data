PImage img;
int drawMode = 1;
int tileCount;
float rectSize;

void setup() {
  size(600, 600);
  background(255);
  noStroke();
  strokeCap(SQUARE); 

  tileCount = 30;
  rectSize = width/ tileCount;

  img = loadImage("02.png");
}

void draw() {
  background(255);

  // factors to tweek the effect
  float mouseXFactor = map(mouseX, 0, width, 0.05, 1);
  float mouseYFactor = map(mouseY, 0, width, 0.05, 1);

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
        // grayscale to line
        noFill();
        stroke(0);
        strokeCap(SQUARE);
        if ( grayScale < 128 ) {
          strokeWeight(1);
          line(rectX, rectY, rectX + rectSize, rectY + rectSize);
        } else {
          strokeWeight(10 * mouseXFactor);
          line(rectX, rectY + rectSize, rectX + rectSize, rectY);
        }
      } else if (drawMode == 2) {
        // grayscale to line
        float stroke = map(grayScale, 0, 255, 15, 0.1);
        noFill();
        stroke(0);
        strokeWeight(stroke * mouseXFactor);
        line(rectX, rectY, rectX + rectSize, rectY + rectSize);
      } else if (drawMode == 3) {
        // grayscale to circle size
        fill(c);
        noStroke();
        float ellipseSize = map(grayScale, 0, 255, rectSize * 2, 0);
        ellipse(centerX, centerY, ellipseSize * mouseXFactor, ellipseSize * mouseXFactor);
      } else if (drawMode == 4) {
        // grayscale to rotation
        float stroke = map(grayScale, 0, 255, 15, 0.1);
        noFill();
        stroke(0);
        strokeWeight(stroke * mouseXFactor);
        pushMatrix();
        translate(px, py);
        rotate(grayScale/255.0 * PI * mouseYFactor);
        line(0, 0, rectSize, rectSize);
        popMatrix();
      } else if (drawMode == 5) {
        // grayscale to eyes
        float ellipseSize = rectSize;
        // draw background circle
        fill(c);
        noStroke();
        ellipse(centerX, centerY, ellipseSize, ellipseSize);
        // draw white pupil
        fill(255);
        // iris size
        float eyeSize = map(brightness(c), 0, 255, rectSize * 0.2, rectSize * 0.8 * mouseYFactor);
        // map iris position using radius and angle
        float eyeRadius = map(hue(c), 0, 255, 0, ellipseSize/2 - eyeSize/2);
        float eyeAngle = map(saturation(c), 0, 255, 0, PI * 2 * mouseXFactor);
        // use trigonometry to calculate the position
        float eyeX = cos(eyeAngle) * eyeRadius + rectX + rectSize/2;
        float eyeY = sin(eyeAngle) * eyeRadius + rectY + rectSize/2;
        // draw iris out
        ellipse(eyeX, eyeY, eyeSize, eyeSize);
      } else if (drawMode == 6) {
        // greyscale to linked line
        float stroke = map(grayScale, 0, 255, 15, 0.1);
        noFill();
        stroke(0);
        stroke(c);
        strokeWeight(stroke * mouseXFactor);
        // pixel index from the neighbor (next to current one on the right)
        int pxNext = (int)( min(gridX + 1, tileCount - 1) * rectSize ); 
        color c2 = img.get(pxNext, py);
        int grayScale2 = getGrayScale(c2);
        float d1 = map(grayScale, 0, 255, 50 * mouseYFactor, 0);
        float d2 = map(grayScale2, 0, 255, 50 * mouseYFactor, 0);
        line(rectX-d1, rectY+d1, rectX+rectSize-d2, rectY+d2);
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