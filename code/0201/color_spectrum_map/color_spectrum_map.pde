// reference
// https://processing.org/reference/colorMode_.html
// https://processing.org/reference/map_.html

int color_block_size = 50;
int color_steps = 10;

void setup() {
  size(800, 400);
  noStroke();
  background(255);
  colorMode(HSB, 360, 100, 100);

  // Map Hue from color(0, 100, 100) to color(40, 100, 100)
  for (int i=0; i <= color_steps; i++) {
    float hue = map(i, 0, color_steps, 0, 40 );
    color intermediary_color = color(hue, 100, 100);
    fill(intermediary_color);
    rect(100 + color_block_size * i, 100, color_block_size, color_block_size);
  }

  // Map Saturation from color(40, 0, 100) to color(40, 100, 100)
  for (int i=0; i <= color_steps; i++) {
    float saturation = map(i, 0, color_steps, 0, 100 );
    color intermediary_color = color(40, saturation, 100);
    fill(intermediary_color);
    rect(100 + color_block_size * i, 200, color_block_size, color_block_size);
  }


  // Map Brightness from color(40, 100, 0) to color(40, 100, 100)
  for (int i=0; i <= color_steps; i++) {
    float saturation = map(i, 0, color_steps, 0, 100 );
    color intermediary_color = color(40, 100, saturation);
    fill(intermediary_color);
    rect(100 + color_block_size * i, 300, color_block_size, color_block_size);
  }
}