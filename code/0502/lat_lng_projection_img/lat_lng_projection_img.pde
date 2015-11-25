import org.gicentre.utils.spatial.*;

ArrayList<PVector> coords;
PVector tlCorner, brCorner;   // Corners of map in WebMercator coordinates.
Float tlLat, tlLng, brLat, brLng;


// 67.8516,4.7407,141.3281,61.3546

void setup()
{
  size(800, 800, P2D);
  noStroke();
  smooth();

  // add background color
  background(255);

  // draw background image
  PImage bgImage = loadImage("china.png");
  image(bgImage, 0, 0);

  loadData();
  drawData();
}

void loadData() {
  // top left corner 
  tlLat = 61.3546;
  tlLng = 67.8516;
  brLat = 4.7407;
  brLng = 141.3281;
  
  coords = new ArrayList<PVector>(); 
  Table citiesTable = loadTable("../cities.csv", "header");

  // create projection
  WebMercator proj = new WebMercator();

  for ( TableRow row : citiesTable.rows () ) {
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    String city = row.getString("city");
    //println(lng, lat);
    if(city.indexOf("市") > -1){
      coords.add(proj.transformCoords(new PVector(lng, lat)));
    }
  }

  // Store the WebMercator coordinates of the corner of the map.
  // The lat/long of the corners was provided by OpenStreetMap
  // when exporting the map tile.
  tlCorner = proj.transformCoords(new PVector(tlLng, tlLat));
  brCorner = proj.transformCoords(new PVector(brLng, brLat));
}

void drawData() {
  fill(0, 0, 0, 127);
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