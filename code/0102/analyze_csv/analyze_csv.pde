// The following short CSV file called "food_formatted.csv" is parsed
// in the code below. It must be in the project's "data" folder.
//
// sample data from file
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

Table food_table;
Meal[] all_meals;
int meals_count;

void setup() {

  // load data from file into memory
  food_table = loadTable("food_formatted.csv", "header");

  // store number of rows
  meals_count = food_table.getRowCount();
  // create array of object
  all_meals = new Meal[meals_count];

  // loop through all meals
  int row_index = 0;
  for (TableRow row : food_table.rows()) {
    //int id = row.getInt("id");
    String start_date = row.getString("start");
    String end_date = row.getString("end"); //<>//
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");

    // created new meal object and save into all meals array
    all_meals[row_index] = new Meal(start_date, end_date, yummy, healthy, ingredients);
    row_index ++;
  }
}

void draw() {
}

void keyPressed() {
  if (key == '1') {
    getGeneralStatistics();
  }
  else if(key == '2') {
    findEarlistMeal();
  }
  else if(key == '3') {
    findMostHappyMeal();
  }
}


void getGeneralStatistics() {
  int[] values = new int[meals_count];
  int total = 0;
  for (int i=0; i<meals_count; i++) {
    values[i] = all_meals[i].duration;
    total += values[i];
  }
  println();
  println("The max minutes is: " + max(values) + ", the min minutes is: " + min(values));
  println("The total is: " + total + ", the average is: " + total/meals_count);
  println("------------------------------------------");
}

void findEarlistMeal() {
  int earliest_index = 0;
  long earliest_meal_absolute_time = 24 * 60; // largest minutes number in a day
  for (int i=0; i<meals_count; i++) {
    if( all_meals[i].start.getHours() * 60 + all_meals[i].start.getMinutes() < earliest_meal_absolute_time) {
        earliest_meal_absolute_time = all_meals[i].start.getHours() * 60 + all_meals[i].start.getMinutes();
        earliest_index = i;
    }
  }
  Meal earliest_meal = all_meals[earliest_index];
  println();
  println("The earliest meal is: No." + earliest_index + " with timestamp of '" + earliest_meal.start.toString() + "'.");
  println("------------------------------------------");
}

// Yummy and Healthy
void findMostHappyMeal() {
  float yummy_weight = 0.8; // 0.8 means 80% 
  float healthy_weight = 0.2; // healthy_weight + yummy_weight = 1
  int happiest_index = 0; // store happiest meal index
  float happiest_score = 0; //store happiest meal score
  for (int i=0; i<meals_count; i++) {
    // check whether score is bigger than current highest one
    if( all_meals[i].yummy*yummy_weight + all_meals[i].healthy*healthy_weight > happiest_score) {
        // store current one as highest
        happiest_score = all_meals[i].yummy * yummy_weight + all_meals[i].healthy * healthy_weight;
        // store its index
        happiest_index = i;
    }
  }
  // retrieve the happiest meal by index
  Meal happiest_meal = all_meals[happiest_index];
  println();
  println("The happiest meal is: No." + happiest_index + " with ingridences: '" + happiest_meal.ingredients + "'.");
  println("------------------------------------------");
}