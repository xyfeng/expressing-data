// Reference
// Exiftool
// exiftool -csv -CreateDate -imageWidth -imageHeight -Orientation -ShutterSpeed -GPSAltitude -GPSLatitude -GPSLongitude *.jpg > metadata.csv

import java.util.Arrays;

int photosCount;
Photo[] allPhotos;

int rowNum;
int colNum;
int photoWidth;
int photoHeight;

void setup() {
  size(1000, 600);
  background(255);
  noStroke();

  rowNum = 4;
  colNum = 5;
  photoWidth = width / colNum;
  photoHeight = height / rowNum;

  loadPhotos();
  sortPhotos();
  drawPhotos();
}

void draw() {
}

void loadPhotos() {
  Table metaTable = loadTable("metadata.csv", "header");
  photosCount = metaTable.getRowCount();
  allPhotos = new Photo[photosCount];

  int index = 0;
  for ( TableRow row : metaTable.rows() ) {
    String fileName = row.getString("SourceFile");
    String fileDate = row.getString("CreateDate");
    int fileWidth = row.getInt("ImageWidth");
    int fileHeight = row.getInt("ImageHeight");
    String orientation = row.getString("Orientation");
    String shutterSpeed = row.getString("ShutterSpeed");
    String altitude = row.getString("GPSAltitude");
    String latitude = row.getString("GPSLatitude");
    String longitude = row.getString("GPSLongitude");

    Photo one = new Photo(fileName, fileDate, fileWidth, fileHeight, orientation, shutterSpeed, altitude, latitude, longitude);
    println(one.name, one.created.getTime(), one.isLandscape, one.shutterSpeed, one.altitude, one.latitude, one.longitude);
    allPhotos[index] = one;
    index ++;
  }
}

void sortPhotos() {
  Arrays.sort(allPhotos, new altitudeComparator());
}

void drawPhotos() {
  for ( int i=0; i<rowNum; i++ ) {
    for ( int j=0; j<colNum; j++) {
      int index = i * colNum + j;
      int posX = photoWidth * j;
      int posY = photoHeight * i;
      Photo one = allPhotos[index];
      image(one.img, posX, posY, photoWidth, photoHeight);
    }
  }
}