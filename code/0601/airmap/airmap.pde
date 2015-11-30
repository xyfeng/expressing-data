// Open Flights Data
// http://openflights.org/data.html

// step1: find airports in china
// step2: find all destinations associated with that airport
// step3: draw arc between airports

import org.gicentre.utils.spatial.*;

// maps
PVector tlCorner, brCorner;   // Corners of map in WebMercator coordinates.
Float tlLat, tlLng, brLat, brLng;
WebMercator proj;

// data
ArrayList<Airport> airportArray;
ArrayList<Airline> airlineArray;
ArrayList<Route> routeArray;

void setup()
{
  size(1000, 736, P2D);
  background(255);
  smooth();

  setupMap();

  // load airlines/airports/routes data
  loadData();

  noFill();

  for ( Airport startAir : airportArray ) {
    // filter out the airpots out of the canvas
    if (startAir.latitude < brLat || startAir.latitude > tlLat) {
      continue;
    }
    if (startAir.longitude < tlLng || startAir.longitude > brLng) {
      continue;
    }
    // check whether it's airport, there are other transportation data like railway and ferries
    if ( startAir.iata.length() == 3 ) {
      println(startAir.name);
      drawAllRoutes(startAir);
    }
  }
}

void setupMap() {
  // create projection
  proj = new WebMercator();

  // World Map
  //tlLng = -180.0;
  //tlLat = 82.0;
  //brLng = 180.0;
  //brLat = -82.0;

  // China Map
  tlLng = 73.554302;
  tlLat = 53.562517;
  brLng = 134.775703;
  brLat = 18.153878;

  tlCorner = proj.transformCoords(new PVector(tlLng, tlLat));
  brCorner = proj.transformCoords(new PVector(brLng, brLat));
}

void loadData() {
  // load airports
  airportArray = new ArrayList<Airport>();
  Table airportsTable = loadTable("../airports.csv", "header");

  for ( TableRow row : airportsTable.rows () ) {
    int id = row.getInt("id");
    String name = row.getString("name");
    String city = row.getString("city");
    String country = row.getString("country");
    String iata = row.getString("iata");
    String icao = row.getString("icao");
    float latitude = row.getFloat("latitude");
    float longitude = row.getFloat("longitude");
    float altitude = row.getFloat("altitude");
    int timezone = row.getInt("timezone");
    String dst = row.getString("dst");
    String tz = row.getString("tz");

    Airport one = new Airport(id, name, city, country, iata, icao, latitude, longitude, altitude, timezone, dst, tz);
    airportArray.add(one);
  }

  // load airlines
  airlineArray = new ArrayList<Airline>();
  Table airlineTable = loadTable("../airlines.csv", "header");

  for ( TableRow row : airlineTable.rows () ) {
    int id = row.getInt("id");
    String name = row.getString("name");
    String alias = row.getString("alias");
    String iata = row.getString("iata");
    String icao = row.getString("icao");
    String callsign = row.getString("callsign");
    String country = row.getString("country");
    String active = row.getString("active");

    Airline one = new Airline(id, name, alias, iata, icao, callsign, country, active);
    airlineArray.add(one);
  }

  // load route
  routeArray = new ArrayList<Route>();
  Table routeTable = loadTable("../routes.csv", "header");

  for ( TableRow row : routeTable.rows () ) {
    String airline = row.getString("airline");
    int id = row.getInt("id");
    String source = row.getString("source");
    int sourceID = row.getInt("sourceID");
    String destination = row.getString("destination");
    int destinationID = row.getInt("destinationID");
    int stops = row.getInt("stops");

    Route one = new Route(airline, id, source, sourceID, destination, destinationID, stops);
    routeArray.add(one);
  }
}

void drawAllRoutes(Airport srcAirport) {
  String sourceIATA = srcAirport.iata;
  for (Route oneRoute : routeArray) {
    // find one airport 
    if ( oneRoute.source.equals(sourceIATA) ) {
      //println(one.destination);
      for (Airport desAirport : airportArray) {
        if ( desAirport.iata.equals(oneRoute.destination)) {
          // find airline id
          int airlineID = oneRoute.id;
          // find airline index
          int airlineIndex = 0;
          for (int index=0; index < airlineArray.size(); index++) {
            Airline oneAirline = airlineArray.get(index);
            if ( oneAirline.id == airlineID) {
              airlineIndex = index;
              break;
            }
          }
          color lineColor = lerpColor(color(60, 180, 30, 3), color(60, 30, 180, 3), airlineIndex/float(airlineArray.size()) );
          // draw arcs
          stroke(lineColor);
          drawArc(new PVector(srcAirport.longitude, srcAirport.latitude), new PVector(desAirport.longitude, desAirport.latitude));
          break;
        }
      }
    }
  }
}

void drawAirports() {
  noStroke();
  fill(255, 120);
  for ( Airport one : airportArray) {
    PVector scrCoord = geoToScreen(proj.transformCoords(new PVector(one.longitude, one.latitude)));
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