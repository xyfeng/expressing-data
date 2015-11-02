// reference
// https://processing.org/reference/colorMode_.html
void setup() {
  size(800,800);
  noStroke();
  colorMode(HSB, width, height, 100);
  for (int i=0; i < width; i++) {
    for (int j=0; j < height; j++) {
      fill(i,j,100);
      rect(i, j, 1, 1);
    }
  }
}