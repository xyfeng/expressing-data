// Reference
// Exiftool
// exiftool -csv -CreateDate -imageWidth -imageHeight -Orientation -ShutterSpeed -GPSAltitude -GPSLatitude -GPSLongitude *.JPG > metadata.csv

import java.util.Arrays;

int photosCount;
Photo[] allPhotos;
Pixel[] allPixels;

void setup() {
  size(362, 500);
  background(0);
  noStroke();
  frameRate(2);

  allPixels = new Pixel[width * height];
  for (int i=0; i<width*height; i++) {
    allPixels[i] = new Pixel(0, 0, 0);
  }
  loadPhotos();
}

void draw() {
  if (frameCount <= allPhotos.length) {
    Photo one = allPhotos[frameCount-1];
    drawPhoto(one.img, frameCount);
  }
}

void loadPhotos() {
  Table metaTable = loadTable("metadata.csv", "header");
  photosCount = metaTable.getRowCount();
  allPhotos = new Photo[photosCount];

  int index = 0;
  for ( TableRow row : metaTable.rows () ) {
    String fileName = row.getString("SourceFile");
    String fileSize = row.getString("FileSize");
    int imageWidth = row.getInt("ImageWidth");
    int imageHeight = row.getInt("ImageHeight");

    Photo one = new Photo(fileName, fileSize, imageWidth, imageHeight);
    println(one.name, one.fileSize);
    allPhotos[index] = one;
    index ++;
  }
}

void drawPhoto(PImage img, int number) {
  loadPixels();
  for ( int m=0; m < width; m++) {
    for (int n=0; n < height; n++) {
      color c = img.get(m, n);
      int index = width * n + m;
      allPixels[index].addColor(c, number);
      pixels[index] = allPixels[index].getColor();
    }
  }
  updatePixels();
}

