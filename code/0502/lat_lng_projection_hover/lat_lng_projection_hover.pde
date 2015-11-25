import org.gicentre.utils.spatial.*;

int pointsNum = 100;
ArrayList<City> coords;
PVector tlCorner, brCorner;   // Corners of map in WebMercator coordinates.
Float tlLat, tlLng, brLat, brLng;
String currentCity = "";
float currentCityPosX, currentCityPosY;

void setup()
{
  size(800, 800, P2D);
  noStroke();
  smooth();
  loadData();
  
  // check fonts in system
  String[] fontList = PFont.list();
  printArray(fontList);
  
  // load font
  PFont font = createFont("Times-Bold", 16);
  textFont(font);
}

void draw() {
  // draw background image
  PImage bgImage = loadImage("china.png");
  image(bgImage, 0, 0);
  
  drawData();
}

void loadData() {
  // top left corner 
  tlLat = 57.1362;
  tlLng = 71.3672;
  brLat = 4.5655;
  brLng = 136.7578;

  coords = new ArrayList<City>(); 
  Table citiesTable = loadTable("../cities.csv", "header");

  // create projection
  WebMercator proj = new WebMercator();

  for ( TableRow row : citiesTable.rows () ) {
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    String cityName = row.getString("city");
    //println(lng, lat);
    if (cityName.indexOf("市") > -1) {
      PVector pos = proj.transformCoords(new PVector(lng, lat));
      coords.add(new City(pos, cityName));
    }
  }

  // Store the WebMercator coordinates of the corner of the map.
  // The lat/long of the corners was provided by OpenStreetMap
  // when exporting the map tile.
  tlCorner = proj.transformCoords(new PVector(tlLng, tlLat));
  brCorner = proj.transformCoords(new PVector(brLng, brLat));
}

void drawData() {
  fill(255, 0, 0);
  for ( City city : coords) {
    PVector scrCoord = geoToScreen(city.pos);
    //println(scrCoord.x, scrCoord.y);
    ellipse(scrCoord.x, scrCoord.y, 3, 3);
    
    if ( dist(scrCoord.x, scrCoord.y, mouseX, mouseY) < 5) {
      //println(city.name);
      currentCity = city.name;
      currentCityPosX = scrCoord.x;
      currentCityPosY = scrCoord.y;
    }
  }
  
  fill(0, 0, 180);
  text(currentCity, currentCityPosX, currentCityPosY);
}

// Convert from WebMercator coordinates to screen coordinates.
PVector geoToScreen(PVector geo)
{
  return new PVector(map(geo.x, tlCorner.x, brCorner.x, 0, width), 
    map(geo.y, tlCorner.y, brCorner.y, 0, height));
}