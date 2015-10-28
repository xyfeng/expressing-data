// References
// http://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html
// http://docs.oracle.com/javase/8/docs/api/java/util/Date.html

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

class Meal {
  Date start;
  Date end;
  int yummy;
  int healthy;
  int duration;
  String ingredients;

  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  Meal( String start_str, String end_str, int y, int h, String i ) {
    yummy = y;
    healthy = h;
    ingredients = i;
    try {
      start = format.parse(start_str);
      end = format.parse(end_str);
    }
    catch(ParseException e){
       e.printStackTrace();
    }
    duration = int(end.getTime() - start.getTime())/(1000 * 60);
  }
}