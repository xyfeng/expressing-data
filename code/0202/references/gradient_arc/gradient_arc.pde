void setup() {
  size(400, 400, P2D);//
}

void draw() {
  background(255);
  drawArc(width/2, height/2, 100, color(180, 30, 90), color(30, 210, 90), 5, -PI, PI/3);
}

/*
  cx: centerX
 cy: centerY
 r: radius
 c1: gradientStart
 c2: gradientEnd
 l: arcThickness
 sa: startAngle
 ea: endAngle
 */
void drawArc(float cx, float cy, float r, color c1, color c2, float l, float sa, float ea) {
  int lineSegments = 720; //density
  noFill();
  float sd = degrees(sa);
  float ed = degrees(ea);
  float angleDiff = ed - sd;
  float lineCount = angleDiff / 360 * lineSegments;
  beginShape(LINES);
  for ( int i=0; i<lineCount; i++ ) {
    color c = lerpColor(c1, c2, (float)i/lineCount);
    stroke(c);
    float radiant = sa + (ea - sa)/lineCount * i;
    float lineStartX = cx + r * cos(radiant);
    float lineStartY = cy + r * sin(radiant);
    float lineEndX = cx + (r + l) * cos(radiant);
    float lineEndY = cy + (r + l) * sin(radiant);
    vertex(lineStartX, lineStartY);
    vertex(lineEndX, lineEndY);
  }
  endShape();
}