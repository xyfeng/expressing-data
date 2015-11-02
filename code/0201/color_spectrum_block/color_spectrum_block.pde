// reference
// https://processing.org/reference/colorMode_.html
int color_block_size = 20;
void setup() {
  size(800,800);
  noStroke();
  colorMode(HSB, width/color_block_size, height/color_block_size, 100);
  for (int i=0; i < width/color_block_size; i++) {
    for (int j=0; j < height/color_block_size; j++) {
      fill(i,j,100);
      rect(i*color_block_size, j*color_block_size, color_block_size, color_block_size);
    }
  }
}