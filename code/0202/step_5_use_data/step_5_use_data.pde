Meal[] all_meals;  // Array of Meals
int meals_count;  // Total Meals Number
int duration_max;  // Maximum of duration
int duration_min;  // Minimum of duration

int meals_index; // indicate which meal in the array

void setup() {
  loadData();
  analyzeData();

  meals_index = 0;

  // setup Canvas
  size(400, 400);
}

void draw() {
  background(255);
  
  Meal current_meal = all_meals[meals_index];
  int meal_yummy = current_meal.yummy;
  int meal_healthy = current_meal.healthy;
  int meal_duration = current_meal.duration;

  // draw an ellipse and a square
  float meal_size = map(meal_duration, 3, 57, 30, 120);
  float yummy_amount = map(meal_yummy, 0, 10, 0, meal_size);
  float yummy_saturation = map(meal_yummy, 0, 10, 20, 100);
  noStroke();
  colorMode(HSB, 360, 100, 100);
  fill(40, yummy_saturation, 100);
  colorMode(RGB, 255, 255, 255);
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

  color healthy_color_from = color(255, 237, 0);
  color healthy_color_to = color(0, 214, 81);
  color health_color = lerpColor(healthy_color_from, healthy_color_to, meal_healthy / 10.0);
  stroke(health_color);
  strokeWeight(healthy_strokeWeight);
  strokeCap(SQUARE);
  noFill();
  arc(width/2, height/2, healthy_arc_radius, healthy_arc_radius, healthy_arc_start, healthy_arc_end);
}

void mousePressed() {
  meals_index = meals_index + 1;
  if( meals_index == meals_count - 1 ){
    meals_index = 0;
  }
  // print out
  Meal current_meal = all_meals[meals_index];
  println(current_meal.yummy, current_meal.healthy, current_meal.duration);
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