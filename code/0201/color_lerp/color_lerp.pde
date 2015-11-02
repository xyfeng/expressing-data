// reference
// https://processing.org/reference/lerpColor_.html
// lerp color from RGB(255, 180, 0) or HSB(40, 100, 100)
// to RGB(0, 120, 255) or HSB(200, 100, 100)

int color_block_size = 30;
int color_steps = 20;

void setup() {
  size(800,400);
  noStroke();
  background(255);
  
  // lerp using RGB
  colorMode(RGB);
  color from_color = color(255, 180, 0);
  color to_color = color(0, 120, 255);
  for(int i=0; i <= color_steps; i++) {
    float amount = (float)i / color_steps;
    color intermediary_color = lerpColor(from_color, to_color, amount);
    fill(intermediary_color);
    rect(100 + color_block_size * i, 100, color_block_size, color_block_size);
  }
  
  // lerp using HSB
  colorMode(HSB, 360, 100, 100);
  for(int i=0; i <= color_steps; i++) {
    float amount = (float)i / color_steps;
    color intermediary_color = lerpColor(from_color, to_color, amount);
    fill(intermediary_color);
    rect(100 + color_block_size * i, 200, color_block_size, color_block_size);
  }
}