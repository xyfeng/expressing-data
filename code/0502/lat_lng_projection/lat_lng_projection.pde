import org.gicentre.utils.spatial.*;

ArrayList<PVector> coords;
PVector tlCorner, brCorner;   // Corners of map in WebMercator coordinates.

void setup()
{
  size(800, 677, P2D);
  noStroke();
  smooth();
  
  // add background color
  background(0);
  
  // draw background image
  PImage bgImage = loadImage("mercator.jpg");
  image(bgImage, 0, 0);

  loadData();
  drawData();
}

void loadData() {
  coords = new ArrayList<PVector>(); 
  
  Table citiesTable = loadTable("../cities.csv", "header");

  // create projection
  WebMercator proj = new WebMercator();

  for ( TableRow row : citiesTable.rows() ) {
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    //println(lng, lat);
    //coords.add(new PVector(lng, lat));
    coords.add(proj.transformCoords(new PVector(lng, lat)));
  }

  // Store the WebMercator coordinates of the corner of the map.
  // The lat/long of the corners was provided by OpenStreetMap
  // when exporting the map tile.
  tlCorner = proj.transformCoords(new PVector(-180.0, 82));
  brCorner = proj.transformCoords(new PVector( 180.0, -82));
}

void drawData() {
  fill(255, 255, 0, 127);
  for ( PVector coord : coords) {
    PVector scrCoord = geoToScreen(coord);
    //println(scrCoord.x, scrCoord.y);
    ellipse(scrCoord.x, scrCoord.y, 2, 2);
  }
}

// Convert from WebMercator coordinates to screen coordinates.
PVector geoToScreen(PVector geo)
{
  return new PVector(map(geo.x, tlCorner.x, brCorner.x, 0, width), 
    map(geo.y, tlCorner.y, brCorner.y, 0, height));
}