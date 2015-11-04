class Meal {
  int yummy;
  int healthy;
  int duration;

  Meal( int y, int h, int d ) {
    yummy = y;
    healthy = h;
    duration = d;
  }

  void drawData(float posX, float posY) {
    // draw an ellipse and a square
    float meal_size = map(duration, 3, 57, 30, 90);
    float yummy_amount = map(yummy, 0, 10, 0, meal_size);
    float yummy_saturation = map(yummy, 0, 10, 20, 100);
    noStroke();
    colorMode(HSB, 360, 100, 100);
    fill(62, yummy_saturation, 99);
    colorMode(RGB, 255, 255, 255);
    ellipse(posX, posY, meal_size, meal_size);
    fill(255);
    rectMode(CENTER);
    rect(posX, posY-yummy_amount, meal_size + 2, meal_size + 2);

    // draw arc to represent healthy
    float healthy_strokeWeight = map(duration, 3, 57, 12, 6);
    float healthy_arc_start = -PI/2;
    float healthy_amount = map(healthy, 0, 10, 0, PI * 2);
    float healthy_arc_end = -PI/2 + healthy_amount;
    float healthy_arc_radius = meal_size + healthy_strokeWeight * 2;
    // remap healthy data
    float health_amount = map(healthy, 5, 10, 0, 1.0);
    color healthy_color_from = color(255, 220, 160);
    color healthy_color_to = color(0, 214, 81);
    color health_color = lerpColor(healthy_color_from, healthy_color_to, health_amount);
    stroke(health_color);
    strokeWeight(healthy_strokeWeight);
    strokeCap(SQUARE);
    noFill();
    arc(posX, posY, healthy_arc_radius, healthy_arc_radius, healthy_arc_start, healthy_arc_end);
  }
}