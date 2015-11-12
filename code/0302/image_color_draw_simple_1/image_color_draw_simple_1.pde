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
  noCursor();
  strokeCap(SQUARE); 

  img = loadImage("01.jpeg");
}

void draw() {
  background(255);
  // drawing reference rectangle
  fill(240,0,0, 30);
  noStroke();
  rect(0,0,width, 100);
  rect(0,130,width, 100);
  
  
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
    
    //draw the pixal out
    fill(c);
    rect(rectX, rectY, rectSize, rectSize);
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