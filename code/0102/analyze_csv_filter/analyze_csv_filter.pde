// The following short CSV file called "food_formatted.csv" is parsed
// in the code below. It must be in the project's "data" folder.
//
// id,start,end,yummy,healthy,ingredients
// 0,2015-10-14 08:48:00,2015-10-14 08:55:00,8,10,fruits|nuts
// 1,2015-10-14 13:22:00,2015-10-14 13:31:00,5,3,bread
// 2,2015-10-14 13:33:00,2015-10-14 13:58:00,7,8,salad|fruits
//
// Reference
// https://processing.org/reference/loadTable_.html
// https://processing.org/tutorials/objects/
// https://processing.org/reference/Array.html
// https://processing.org/reference/key.html
// https://processing.org/reference/sort_.html
// http://docs.oracle.com/javase/7/docs/api/java/util/Arrays.html

import java.util.Arrays;

Table food_table;
Meal[] all_meals;
int meals_count;

void setup() {

  food_table = loadTable("food_formatted.csv", "header");

  meals_count = food_table.getRowCount();
  all_meals = new Meal[meals_count];

  // read and format the data
  int row_index = 0;
  for (TableRow row : food_table.rows()) {
    //int id = row.getInt("id");
    String start_date = row.getString("start");
    String end_date = row.getString("end");
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");

    all_meals[row_index] = new Meal(start_date, end_date, yummy, healthy, ingredients);
    row_index ++;
  }
}

void draw() {
}

void keyPressed() {
  if (key == '1') {
    println();
    findMealsLessThan10Minutes();
    println("------------------------------------------");
  } else if (key == '2') {
    findAndSortMealsLessThan10Minutes();
  }
}

void findMealsLessThan10Minutes() {
  for ( Meal one : all_meals ) {
    if ( one.duration < 10 ) {
      one.printOut();
    }
  }
}

void findAndSortMealsLessThan10Minutes() {
  Meal[] copied = Arrays.copyOf(all_meals, meals_count);
  Arrays.sort(copied, new MealDurationComparator());
  ArrayList<Meal> filtered = new ArrayList<Meal>();
  for ( Meal one : copied ) {
    if ( one.duration < 10 ) {
      filtered.add(one);
    }
  }
  for ( Meal one : filtered ) {
    one.printOut();
  }
}