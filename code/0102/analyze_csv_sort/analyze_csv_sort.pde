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
  // load data from file into memory
  food_table = loadTable("food_formatted.csv", "header");
  // store number of rows
  meals_count = food_table.getRowCount();
  // initialize all meals array
  all_meals = new Meal[meals_count];

  // loop through all meals
  int row_index = 0;
  for (TableRow row : food_table.rows()) {
    //int id = row.getInt("id");
    String start_date = row.getString("start");
    String end_date = row.getString("end");
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");
    
    // create a new meal object and store it in the array
    all_meals[row_index] = new Meal(start_date, end_date, yummy, healthy, ingredients);
    row_index ++;
  }
}

void draw() {
}

void keyPressed() {
  if (key == '1') {
    println("Before Sort by Yummy:");
    for( Meal one : all_meals ){
      one.printOut();
    }
    // sort the array of objects by comparing a value from it
    Arrays.sort(all_meals, new MealYummyComparator());
    println("After Sort by Yummy:");
    for( Meal one : all_meals ){
      one.printOut();
    }
    println("------------------------------------------");
  } else if (key == '2') {
    println("Before Sort by Healthy:");
    for( Meal one : all_meals ){
      one.printOut();
    }
    // sort the array of objects by comparing a value from it
    Arrays.sort(all_meals, new MealHealthyComparator());
    println("After Sort by Healthy:");
    for( Meal one : all_meals ){
      one.printOut();
    }
    println("------------------------------------------");
  }
}