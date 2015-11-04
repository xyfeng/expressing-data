Meal[] all_meals;  // Array of Meals
int meals_count;  // Total Meals Number

void setup() {
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
    println(new_meal.yummy, new_meal.healthy, new_meal.duration);
  }
}

void draw() {}