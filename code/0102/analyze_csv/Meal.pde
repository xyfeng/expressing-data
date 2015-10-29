// References
// http://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html
// http://docs.oracle.com/javase/8/docs/api/java/util/Date.html

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

class Meal {
  Date start; // store as Date format
  Date end;
  int yummy;
  int healthy;
  int duration;
  String ingredients;

  // create a new date format by using a string, this should match the data you have in the csv file
  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  // object initializer
  Meal( String start_str, String end_str, int y, int h, String i ) {
    yummy = y;
    healthy = h;
    ingredients = i;
    try {
      // parse date string to date object using formatter
      start = format.parse(start_str);
      end = format.parse(end_str);
    }
    catch(ParseException e){
       e.printStackTrace();
    }
    // calculate the duration
    duration = int(end.getTime() - start.getTime())/(1000 * 60);
  }
}