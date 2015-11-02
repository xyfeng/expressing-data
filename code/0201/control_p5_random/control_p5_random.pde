// reference
// https://github.com/sojamo/controlp5

import controlP5.*;

ControlP5 cp5;
Slider widthSlider;
Slider heightSlider;
Textfield rectNameField;


int rectWidth = 100;
int rectHeight = 100;
String textLabel = "Text";

void setup() {
  size(400, 400);
  noStroke();

  /* load font */
  PFont font = createFont("arial", 20);

  /* new instance of ControlP5 */
  cp5 = new ControlP5(this);

  /* add controllers and give each of them a unique id. */
  // setup slider to control rectangle width
  widthSlider = cp5.addSlider("width")
    .setPosition(295, 5)
    .setSize(100, 15)
    .setId(1)
    .setValue(rectWidth)
    .setRange(0, 300)
    .setNumberOfTickMarks(5); // only allow for 5 stops

  // setup slider to control rectangle height
  heightSlider = cp5.addSlider("height")
    .setPosition(295, 25)
    .setSize(100, 15)
    .setId(2)
    .setValue(rectHeight)
    .setRange(0, 300);

  // setup text input, hit enter key to trigger event
  rectNameField = cp5.addTextfield("rectName")
    .setPosition(295, 45)
    .setSize(100, 25)
    .setFont(font)
    .setId(3)
    .setValue(textLabel)
    .setFocus(true)
    .setAutoClear(false)
    .setColor(color(255, 255, 255));

  // create a new button with name 'randomize'
  cp5.addButton("randomize")
    .setPosition(295, 75)
    .setSize(100, 15)
    .setId(4);
}

void draw() {
  background(255);
  // draw rectangle
  fill(0);
  rect(50, 50, rectWidth, rectHeight);
  // draw text label
  fill(255);
  textAlign(CENTER);
  text(textLabel, 50 + rectWidth/2, 50 + rectHeight/2);
}


void controlEvent(ControlEvent theEvent) {
  /* events triggered by controllers are automatically forwarded to
   the controlEvent method. by checking the id of a controller one can distinguish
   which of the controllers has been changed.
   */
  println("got a control event from controller with id "+theEvent.getController().getId());
  switch(theEvent.getController().getId()) {
    case(1):
    /* controller posX with id 1 */
    rectWidth = (int)theEvent.getValue();
    break;
    case(2):
    /* controller posX with id 2 */
    rectHeight = (int)theEvent.getValue();
    break;
    case(3):
    /* controller posX with id 3 */
    textLabel = theEvent.getStringValue();
    break;
    case(4):
    // generate random values
    rectWidth = (int)random(0,300);
    rectHeight = (int)random(0,300);
    // sync controlP5 interface
    widthSlider.setValue(rectWidth);
    heightSlider.setValue(rectHeight);
    break;
  }
}
