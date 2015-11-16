// References
// http://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html
// http://docs.oracle.com/javase/8/docs/api/java/util/Date.html

import java.util.Date;
import java.util.Comparator;
import java.text.SimpleDateFormat;

class Photo {
  PImage img;
  String name;
  Date created;
  int imageWidth;
  int imageHeight;
  boolean isLandscape;
  float shutterSpeed;
  float altitude;
  float latitude;
  float longitude;

  Photo( String f_name, String c_date, int img_w, int img_h, String img_o, String s_p, String gps_a, String gps_lat, String gps_long) {
    name = f_name;
    img = loadImage(name);
  
    // convert date string to date object
    SimpleDateFormat format = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
    try {
      created = format.parse(c_date);
    }
    catch(Exception e) {
    }

    imageWidth = img_w;
    imageHeight = img_h;

    // from descriptive string to boolean
    isLandscape = img_o.equals("Horizontal (normal)");

    // from String "1/100" to float number 0.1
    shutterSpeed = 1.0 / int( s_p.substring(2, s_p.length()));

    // from descrptive string to float value
    int al_index = gps_a.indexOf(" m ");
    int above_index = gps_a.indexOf("Above");
    altitude = float(gps_a.substring(0, al_index));
    if ( above_index < 0 ) {
      altitude *= -1;
    }

    // convert lat/lng from String to float
    latitude = convertGPS(gps_lat);
    longitude = convertGPS(gps_long);
  }

  float convertGPS(String dms) {
    int degIndex = dms.indexOf(" deg ");
    int minIndex = dms.indexOf("' ");
    int secIndex = dms.indexOf('"');
    // if string contains S or W, multiply by -1
    int muliplier = (dms.indexOf('S') > 0 || dms.indexOf('W') > 0)? -1 : 1;
    int degrees = int(dms.substring(0, degIndex));
    float minutes = float(dms.substring(degIndex + 5, minIndex));
    float seconds = float(dms.substring(minIndex + 2, secIndex));
    return muliplier * ( degrees + (minutes/60) + (seconds/3600));
  }
}

class altitudeComparator implements Comparator<Photo>{
  @Override
  public int compare(Photo o1, Photo o2) {
    return int(o1.altitude - o2.altitude);
  }
}