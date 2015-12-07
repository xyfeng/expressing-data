class Place {
  String name;
  PVector lnglat;
  PVector[] routes;
  
  Place(String _name, float _latitude, float _longitude, PVector[] _routes){
    name = _name;
    lnglat = new PVector(_longitude, _latitude);
    routes = _routes;
  }
}