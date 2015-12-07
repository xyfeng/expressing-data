// Reference
// https://www.mapbox.com/developers/api/static/
//
// List of Map Styles
// https://www.mapbox.com/developers/api/maps/#mapids
//
// Mapbox Gallery
// https://www.mapbox.com/gallery
//
// Test URL 342, 240, 600, 400
// https://api.mapbox.com/v4/mslee.ad466bba/121.52983688273144,31.22797223901206,16/1200x800.png@2x?access_token=pk.eyJ1IjoieHlmZW5nIiwiYSI6IjRZNzdCbEkifQ.y54-xYgxPAeDY0VYy9qEGw
//
// Sample Hacking URL
// https://api.mapbox.com/styles/v1/edenhalperin/cifq0r0e5000q85m0d293k6mq/static/121.52983688273144,31.22797223901206,15/1200x800@2x?access_token=pk.eyJ1IjoiZWRlbmhhbHBlcmluIiwiYSI6IlFRZG0zMWMifQ.QUNKx4tIMjZfwmrE8SE6Bg&logo=false&attribution=false

class Mapbox {
  // Mapbox Configuration
  String AccessToken = "pk.eyJ1IjoieHlmZW5nIiwiYSI6IjRZNzdCbEkifQ.y54-xYgxPAeDY0VYy9qEGw";
  String MapStyleID = "mapbox.comic";
  // properties
  float centerLat;
  float centerLng;
  float latUnit;
  float lngUnit;
  PVector centerCoords;
  int zoomLevel;

  Mapbox(WebMercator _proj, float _centerLat, float _centerLng, int _zoomLevel) {
    centerLat = _centerLat;
    centerLng = _centerLng;
    zoomLevel = _zoomLevel;

    PVector topLeftBBox = proj.transformCoords( new PVector(-180, 85) );
    PVector rightBottomBBox = proj.transformCoords( new PVector(180, -85) );
    centerCoords = proj.transformCoords( new PVector(_centerLng, _centerLat) );
    
    lngUnit = (rightBottomBBox.x - topLeftBBox.x) / (256 * pow(2, zoomLevel));
    latUnit = (topLeftBBox.y - rightBottomBBox.y) / (256 * pow(2, zoomLevel));
  }

  PImage downloadImage() {
    //String imageURL = "https://api.mapbox.com/v4/" + MapStyleID + "/" + centerLng + "," + centerLat + "," + zoomLevel + "/" + width + "x" + height + ".png?access_token=" + AccessToken;
    String imageURL = "https://api.mapbox.com/styles/v1/edenhalperin/cifq0r0e5000q85m0d293k6mq/static/" + centerLng + "," + centerLat + "," + zoomLevel + "/" + width + "x" + height + "@2x?access_token=pk.eyJ1IjoiZWRlbmhhbHBlcmluIiwiYSI6IlFRZG0zMWMifQ.QUNKx4tIMjZfwmrE8SE6Bg&logo=false&attribution=false";
    println(imageURL);
    return loadImage(imageURL, "png");
    //return loadImage("mapbox.png");
  }
  
  PVector getScreenTopLeftCorner() {
    return new PVector(centerCoords.x - width / 2 * lngUnit, centerCoords.y + height / 2 * latUnit);
  }
  
  PVector getScreenBottomRightCorner() {
    return new PVector(centerCoords.x + width / 2 * lngUnit, centerCoords.y - height / 2 * latUnit);
  }
}