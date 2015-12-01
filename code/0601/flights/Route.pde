class Route {
  String airline;
  int id;
  String source;
  int sourceID;
  String destination;
  int destinationID;
  int stops;
  Route(String _airline, int _id, String _source, int _sourceID, String _destination, int _destinationID, int _stops) {
    airline = _airline;
    id = _id;
    source = _source;
    sourceID = _sourceID;
    destination = _destination;
    destinationID = _destinationID;
    stops = _stops;
  }
}