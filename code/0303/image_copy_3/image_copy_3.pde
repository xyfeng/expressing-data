// Reference
// Video: https://viwmeo.com/63635193
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
  File dir = new File(sketchPath("../photos"));
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
  rectWidth = ceil((float)width / imageCount);
}

void draw() {
  if (columnIndex < imageCount) {
    int posX = rectWidth * columnIndex;
    int posY = 0;
    int w = rectWidth;
    int h = height;
    copy(images[columnIndex], posX, posY, w, h, posX, posY, w, h);
    columnIndex++;
  }
}