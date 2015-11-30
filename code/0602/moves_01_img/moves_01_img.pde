// http://openflights.org/data.html
// 31.26424545620498, 121.42879486083987
// 31.201936662304014, 121.56826972961429

import org.gicentre.utils.spatial.*;

ArrayList<PVector> coords;
PVector tlCorner, brCorner;   // Corners of map in WebMercator coordinates.
Float tlLat, tlLng, brLat, brLng;
WebMercator proj;

PVector shCoord;

void setup()
{
  size(840, 426, P2D);
  noStroke();
  smooth();

  // draw background image
  PImage bgImage = loadImage("Shanghai.png");
  image(bgImage, 0, 0);
  
  setupMap();
}

void setupMap() {
  // create projection
  proj = new WebMercator();
  
  tlLng = 121.42879486083987;
  tlLat = 31.26424545620498;
  brLng = 121.56826972961429;
  brLat = 31.201936662304014;

  tlCorner = proj.transformCoords(new PVector(tlLng, tlLat));
  brCorner = proj.transformCoords(new PVector(brLng, brLat));
}


// Convert from WebMercator coordinates to screen coordinates.
PVector geoToScreen(PVector geo)
{
  return new PVector(map(geo.x, tlCorner.x, brCorner.x, 0, width),
    map(geo.y, tlCorner.y, brCorner.y, 0, height));
}