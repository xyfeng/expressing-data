class Airline {
  int id;
  String name;
  String alias;
  String iata;
  String icao;
  String callsign;
  String country;
  String active;
  Airline(int _id, String _name, String _alias, String _iata, String _icao, String _callsign, String _country, String _active) {
    id = _id;
    name = _name;
    alias = _alias;
    iata = _iata;
    icao = _icao;
    callsign = _callsign;
    country = _country;
    active = _active;
  }
}