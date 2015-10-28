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
  long earliest_meal_absolute_time = new Date().getTime();
  for (int i=0; i<meals_count; i++) {
    if( all_meals[i].start.getTime() < earliest_meal_absolute_time) {
        earliest_meal_absolute_time = all_meals[i].start.getTime();
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
  float yummy_weight = 0.5;
  float healthy_weight = 0.5;
  int happiest_index = 0;
  float happiest_score = 0;
  for (int i=0; i<meals_count; i++) {
    if( all_meals[i].yummy*yummy_weight + all_meals[i].healthy*healthy_weight > happiest_score) {
        happiest_score = all_meals[i].yummy * yummy_weight + all_meals[i].healthy * healthy_weight;
        happiest_index = i;
    }
  }
  Meal happiest_meal = all_meals[happiest_index];
  println();
  println("The happiest meal is: No." + happiest_index + " with ingridences: '" + happiest_meal.ingredients + "'.");
  println("------------------------------------------");
}