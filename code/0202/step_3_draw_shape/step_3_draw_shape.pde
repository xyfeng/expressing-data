Meal[] all_meals;  // Array of Meals
int meals_count;  // Total Meals Number
int duration_max;  // Maximum of duration
int duration_min;  // Minimum of duration

int meal_yummy; 
int meal_healthy;
int meal_duration;

void setup() {
  loadData();
  analyzeData();

  // generate a random data
  meal_yummy = (int)random(1, 10);
  meal_healthy = (int)random(1, 10);
  meal_duration = (int)random(duration_min, duration_max);

  // print out
  println(meal_yummy, meal_healthy, meal_duration);
  
  // setup Canvas
  size(400, 400);
}

void draw() {
  background(255);
  
  // draw an ellipse and a square
  float meal_size = map(meal_duration, 3, 57, 30, 120);
  float yummy_amount = map(meal_yummy, 0, 10, 0, meal_size);
  noStroke();
  fill(233, 204, 87);
  ellipse(width/2, height/2, meal_size, meal_size);
  fill(255);
  rectMode(CENTER);
  rect(width/2, height/2-yummy_amount, meal_size + 2, meal_size + 2);
  
  // draw arc to represent healthy
  float healthy_strokeWeight = map(meal_duration, 3, 57, 16, 8);
  float healthy_arc_start = -PI/2;
  float healthy_amount = map(meal_healthy, 0, 10, 0, PI * 2);
  float healthy_arc_end = -PI/2 + healthy_amount;
  float healthy_arc_radius = meal_size + healthy_strokeWeight * 2;
  
  stroke(122,233,132, 200);
  strokeWeight(healthy_strokeWeight);
  strokeCap(SQUARE);
  noFill();
  arc(width/2, height/2, healthy_arc_radius, healthy_arc_radius, healthy_arc_start, healthy_arc_end);
}

void mousePressed(){
  meal_yummy = (int)random(1, 10);
  meal_healthy = (int)random(1, 10);
  meal_duration = (int)random(duration_min, duration_max);
  // print out
  println(meal_yummy, meal_healthy, meal_duration);
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