// Open Flights Data
// http://openflights.org/data.html

import org.gicentre.utils.spatial.*;

ArrayList<PVector> coords;
PVector tlCorner, brCorner;   // Corners of map in WebMercator coordinates.
Float tlLat, tlLng, brLat, brLng;
WebMercator proj;

PVector shCoord;

void setup()
{
  size(773, 569, P2D);
  noStroke();
  smooth();

  // add background color
  background(0);

  // draw background image
  PShape bgShape = loadShape("china.svg");
  shape(bgShape, 0, 0, width, height);

  // create projection
  proj = new WebMercator();

  // load city data
  loadData();

  // draw city dots
  drawCities();

  stroke(255, 255, 0, 30);
  noFill();
  for ( PVector coord : coords ) {
     ArrayList<PVector> segments = getArcSegments(shCoord, coord, 100);
     drawArc(segments);
    //drawLine(shCoord, coord);
  }
}

void loadData() {
  tlLng = 73.554302;
  tlLat = 53.562517;
  brLng = 134.775703;
  brLat = 18.153878;

  tlCorner = proj.transformCoords(new PVector(tlLng, tlLat));
  brCorner = proj.transformCoords(new PVector(brLng, brLat));

  coords = new ArrayList<PVector>();
  Table citiesTable = loadTable("../airports.csv", "header");

  for ( TableRow row : citiesTable.rows () ) {
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    // filter out the airpots out of the canvas
    if (lat < brLat || lat > tlLat) {
      continue;
    }
    if (lng < tlLng || lng > brLng) {
      continue;
    }

    //PVector cityCoord = proj.transformCoords(new PVector(lng, lat));
    PVector cityCoord = new PVector(lng, lat);
    coords.add(cityCoord);
    String city = row.getString("city");
    if (city.indexOf("Shanghai") > -1) {
      shCoord = cityCoord;
    }
  }
}

void drawCities() {
  fill(255, 120);
  for ( PVector coord : coords) {
    PVector scrCoord = geoToScreen(proj.transformCoords(coord));
    ellipse(scrCoord.x, scrCoord.y, 2, 2);
  }
}

// Convert from WebMercator coordinates to screen coordinates.
PVector geoToScreen(PVector geo)
{
  return new PVector(map(geo.x, tlCorner.x, brCorner.x, 0, width), 
    map(geo.y, tlCorner.y, brCorner.y, 0, height));
}

void drawLine(PVector v1, PVector v2) {
  PVector v1Coord = geoToScreen(proj.transformCoords(v1));
  PVector v2Coord = geoToScreen(proj.transformCoords(v2));
  line(v1Coord.x, v1Coord.y, v2Coord.x, v2Coord.y);
}

void drawArc(PVector v1, PVector v2)
{ 
  stroke(255, 255, 0, 30);
  noFill();
  ArrayList<PVector> segments = getArcSegments(v1, v2, 100);
  if (segments != null) {
    beginShape();
    for (PVector seg : segments) {
      PVector coord = geoToScreen(proj.transformCoords(seg));
      vertex(coord.x, coord.y);
    }
    endShape();
  }
}

// v1, v2 are PVector of coordinates ( longitude, latitude )
// num is the number of segments, the value should be greater than 3, bigger number better details
ArrayList<PVector> getArcSegments(PVector v1, PVector v2, int num) 
{
  // limitations of the gicentre utils
  if (abs(v1.y) > 88.0 || abs(v2.y) > 88.0) {
    return null;
  }

  ArrayList<PVector> segments = new ArrayList<PVector>();

  int numberOfSegments = num;
  int onelessNumberOfSeg = numberOfSegments - 1;
  float fractionalIncrement = 1.0/onelessNumberOfSeg;

  float v1LonRadians = radians(v1.x);
  float v1LatRadians = radians(v1.y);
  float v2LonRadians = radians(v2.x);
  float v2LatRadians = radians(v2.y);

  float distanceRadians = 2*asin(sqrt(pow((sin((v1LatRadians-v2LatRadians)/2)), 2) + cos(v1LatRadians)*cos(v2LatRadians)*pow((sin((v1LonRadians-v2LonRadians)/2)), 2)));

  segments.add(v1);

  float f = fractionalIncrement;
  int counter = 1;
  while (counter <  onelessNumberOfSeg) {
    int counterMin = counter - 1;
    // f is expressed as a fraction along the route from point 1 to point 2
    float A = sin((1-f)*distanceRadians) / sin(distanceRadians);
    float B = sin(f*distanceRadians)/sin(distanceRadians);
    float x = A*cos(v1LatRadians)*cos(v1LonRadians) + B*cos(v2LatRadians)*cos(v2LonRadians);
    float y = A*cos(v1LatRadians)*sin(v1LonRadians) +  B*cos(v2LatRadians)*sin(v2LonRadians);
    float z = A*sin(v1LatRadians) + B*sin(v2LatRadians);
    float newlat = atan2(z, sqrt(pow(x, 2) + pow(y, 2)));
    float newlon = atan2(y, x);
    float newlatDegrees = degrees(newlat);
    float newlonDegrees = degrees(newlon);
    if (abs(newlatDegrees) > 88.0) {
      return null;
    }
    segments.add(new PVector(newlonDegrees, newlatDegrees));
    counter += 1;
    f = f + fractionalIncrement;
  }
  segments.add(v2);

  return segments;
}