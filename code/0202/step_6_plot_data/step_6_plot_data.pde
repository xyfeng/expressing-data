Meal[] all_meals;  // Array of Meals
int meals_count;  // Total Meals Number
int duration_max;  // Maximum of duration
int duration_min;  // Minimum of duration

int meals_index; // indicate which meal in the array

void setup() {
  loadData();
  analyzeData();

  // setup Canvas
  size(1200, 720);
}

void draw() {
  background(255);

  for (int i=0; i<7; i++) {
    for (int j=0; j<3; j++) {
      meals_index = i * 3 + j; 
      Meal one_meal = all_meals[meals_index];
      one_meal.drawData(150 + i * 150, 100 + j * 150);
    }
  }
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

void analyzeData() {
  // find range of duration
  int durations[] = new int[meals_count];
  for ( int i=0; i<meals_count; i++ ) {
    Meal one_meal = all_meals[i];
    durations[i] = one_meal.duration;
  }

  duration_max = max(durations);
  duration_min = min(durations);
}