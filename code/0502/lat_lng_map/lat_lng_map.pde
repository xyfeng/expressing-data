int pointsNum = 100;
ArrayList<PVector> coords;

void setup()
{
  size(1200, 800, P2D);
  background(0);
  noStroke();
  smooth();

  loadData();
  drawData();
}

void loadData() {
  // setup an arraylist
  coords = new ArrayList<PVector>(); 
  // load a cities table
  Table citiesTable = loadTable("../cities.csv", "header");
  
  for ( TableRow row : citiesTable.rows() ) {
    float lat = row.getFloat("latitude");
    float lng = row.getFloat("longitude");
    coords.add(new PVector(lng, lat));
    //println(lng, lat);
  }
}

void drawData() {
  fill(255);
  for ( PVector coord : coords) {
    float posX = map(coord.x, -180, 180, 0, width);
    float posY = map(coord.y, 90, -90, 0, height);
    ellipse(posX, posY, 2, 2);
  }
}