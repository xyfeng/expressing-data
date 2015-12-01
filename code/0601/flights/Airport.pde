class Airport {
  int id;
  String name;
  String city;
  String country;
  String iata;
  String icao;
  float latitude;
  float longitude;
  float altitude;
  int timezone;
  String dst;
  String tz;
  Airport(int _id, String _name, String _city, String _country, String _iata, String _icao, float _latitude, float _longitude, float _altitude, int _timezone, String _dst, String _tz) {
    id = _id;
    name = _name;
    city = _city;
    country = _country;
    iata = _iata;
    icao = _icao;
    latitude = _latitude;
    longitude = _longitude;
    altitude = _altitude;
    timezone = _timezone;
    dst = _dst;
    tz = _tz;
  }
}