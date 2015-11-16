// Reference
// Video: https://vimeo.com/63635193
// 1280 x 720

PImage[] images;
String[] imageNames;
int imageCount;

int rectWidth;
int columnIndex;

void setup() {
  size(1280, 720);
  background(255);
  noStroke();

  // load files
  File dir = new File(sketchPath("../photos/"));
  if (dir.isDirectory()) {
    String[] contents = dir.list();
    images = new PImage[contents.length]; 
    imageNames = new String[contents.length]; 
    println(contents.length);
    for (int i = 0; i < contents.length; i++) {
      if (contents[i].toLowerCase().endsWith(".png")) {
        File childFile = new File(dir, contents[i]);        
        images[imageCount] = loadImage(childFile.getPath());
        imageNames[imageCount] = childFile.getName();
        println(imageCount+" "+contents[i]+"  "+childFile.getPath());
        imageCount++;
      }
    }
  }

  columnIndex = 0;
  rectWidth = ceil((float)width / imageCount) + 10;
}

void draw() {
  if (columnIndex < imageCount) {
    int posX = rectWidth * columnIndex;
    int posY = 0;
    int w = rectWidth;
    int h = height;
    //copy(images[columnIndex], posX, posY, w, h, posX, posY, w, h);
    copyStripe(images[columnIndex], posX, w, -200);
    columnIndex++;
  }
}

void copyStripe(PImage img, int x, int w, int offsetX){
  for(int i=x; i<x+w; i++){
    for(int j=0; j<height; j++){
      int px = i + (int)map(j, 0, height, 0, offsetX);
      int py = j;
      color c = img.get(px,py);
      stroke(c);
      point(px,py);
    }
  }
}