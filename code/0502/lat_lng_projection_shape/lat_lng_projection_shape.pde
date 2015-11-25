import org.gicentre.utils.spatial.*;

ArrayList<PVector> coords;
PVector tlCorner, brCorner;   // Corners of map in WebMercator coordinates.
Float tlLat, tlLng, brLat, brLng;

void setup()
{
  size(773, 569, P2D);
  noStroke();
  smooth();

  // add background color
  background(255);

  // draw background image
  PShape bgShape = loadShape("china_new.svg");
  shape(bgShape, 0, 0, width, height);

  loadData();
  drawData();
}

void loadData() {
  // top left corner 
  tlLng = 73.554302;
  tlLat = 53.562517;
  brLng = 134.775703;
  brLat = 18.153878;
  
  coords = new ArrayList<PVector>(); 
  Table citiesTable = loadTable("../cities.csv", "header");

  // create projection
  WebMercator proj = new WebMercator();

  for ( TableRow row : citiesTable.rows () ) {
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    String city = row.getString("city");
    //println(lng, lat);
    //coords.add(new PVector(lng, lat));
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
  fill(255, 0, 0, 127);
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