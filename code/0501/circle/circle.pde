int pointsNum = 100;

void setup()
{
  size(400, 200, P2D);
  noFill();
  stroke(255);
  strokeCap(ROUND);
  ellipse(100, 100, 120, 120);
  smooth();

 for (int i=0; i < pointsNum; i++)
 {
   //strokeWeight(3);
   //float angle = map(i, 0, pointsNum, 0, PI*2);
   //point(300 + cos(angle) * 60, 100 + sin(angle) * 60);
   float a1 = map(i, 0, pointsNum, 0, PI*2);
   float a2 = map(i + 1, 0, pointsNum, 0, PI*2);
   line(300 + cos(a1) * 60, 100 + sin(a1) * 60, 300 + cos(a2) * 60, 100 + sin(a2) * 60);
 }
}