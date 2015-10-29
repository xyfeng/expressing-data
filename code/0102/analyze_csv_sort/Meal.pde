// References
// http://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html
// http://docs.oracle.com/javase/8/docs/api/java/util/Date.html
// http://docs.oracle.com/javase/7/docs/api/java/lang/Comparable.html
// http://www.programcreek.com/2013/11/arrays-sort-comparator/

import java.util.Date;
import java.util.Comparator;
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
  
  // print out
  void printOut(){
    println("timestamp: "+start.toString() + ", yummy: " + yummy + ", healthy: " + healthy + ", ingredients: " + ingredients);
  }
}

// yummy comparator, follow the structure, and use is as an add-on to your object class
class MealYummyComparator implements Comparator<Meal>{
  @Override
  public int compare(Meal o1, Meal o2) {
    // return 0 if equal, < 0 if less, > 0 if greater 
    return o1.yummy - o2.yummy;
  }
}

// healthy comparator, follow the structure, and use is as an add-on to your object class
class MealHealthyComparator implements Comparator<Meal>{
  @Override
  public int compare(Meal o1, Meal o2) {
    // return 0 if equal, < 0 if less, > 0 if greater 
    return o1.healthy - o2.healthy;
  }
}