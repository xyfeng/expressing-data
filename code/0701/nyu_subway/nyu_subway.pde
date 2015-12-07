import org.gicentre.utils.spatial.*;

Mapbox mapbox;
WebMercator proj;

PVector tlCorner, brCorner, centerPOS;

// data
ArrayList<Place> placeArray;

void setup()
{
  size(1200, 800, P2D);
  // set for retina display
  pixelDensity(displayDensity());

  noStroke();
  smooth();

  setupMap();
  
  // draw background image
  PImage bgImage = mapbox.downloadImage();
  image(bgImage, 0, 0, width, height);

  loadData();
  drawData();
}

void setupMap() {
  // create projection
  proj = new WebMercator();
  mapbox = new Mapbox(proj, 40.730859, -73.997448, 16);

  tlCorner = mapbox.getScreenTopLeftCorner();
  brCorner = mapbox.getScreenBottomRightCorner();
}

void loadData() {
  placeArray = new ArrayList<Place>();
  Table placesTable = loadTable("places_newyork.csv", "header");
  for ( TableRow row : placesTable.rows() ) {
    float latitude = row.getFloat("endLat");
    float longitude = row.getFloat("endLng");
    String fileName = row.getString("filename");

    Place one = new Place("", latitude, longitude, loadFile(fileName) );
    placeArray.add(one);
  }
}

PVector[] loadFile(String fn) {
  PVector[] results;
  Table fileTable = loadTable(fn, "header");
  results = new PVector[fileTable.getRowCount()];
  int index = 0;
  for (TableRow row : fileTable.rows()) {
    float latitude = row.getFloat("latitude");
    float longitude = row.getFloat("longitude");
    results[index] = new PVector(longitude, latitude);
    index ++;
  }
  return results;
}

void drawData() {
  for (Place one : placeArray) {
    // draw routes
    stroke(255, 255, 0, 120);
    strokeWeight(2);
    noFill();
    beginShape();
    for ( PVector lnglat : one.routes ) {
     PVector geo = proj.transformCoords(lnglat);
     PVector coord = geoToScreen(geo);
     vertex(coord.x, coord.y);
    }
    endShape();
    // draw location
    fill(255, 255, 0, 120);
    noStroke();
    PVector geo = proj.transformCoords(one.lnglat);
    PVector coord = geoToScreen(geo);
    ellipse(coord.x, coord.y, 20, 20);
  }
}


// Convert from WebMercator coordinates to screen coordinates.
PVector geoToScreen(PVector geo)
{
  return new PVector(map(geo.x, tlCorner.x, brCorner.x, 0, width ), 
    map(geo.y, tlCorner.y, brCorner.y, 0, height) );
}