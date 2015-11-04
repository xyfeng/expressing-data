Meal[] all_meals;  // Array of Meals
int meals_count;  // Total Meals Number

void setup() {
  loadData();

  // find range of duration
  int durations[] = new int[meals_count];
  for ( int i=0; i<meals_count; i++ ) {
    Meal one_meal = all_meals[i];
    durations[i] = one_meal.duration;
  }
  
  // print out
  println("Max duration is " + max(durations) + " minutes");
  println("Min duration is " + min(durations) + " minutes");
}

void draw() {
}

void loadData() {
  /* load data */
  Table meals_table = loadTable("meals.csv", "header");
  meals_count = meals_table.getRowCount();
  all_meals = new Meal[meals_count];
  // loop through all meals
  int row_index = 0;
  for (TableRow row : meals_table.rows()) {
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    int duration = row.getInt("duration");
    // created new meal object and save into meals array
    Meal new_meal = new Meal(yummy, healthy, duration);
    all_meals[row_index] = new_meal;
    row_index ++;  // pointing to the next value
    // debug
    //println(new_meal.yummy, new_meal.healthy, new_meal.duration);
  }
}