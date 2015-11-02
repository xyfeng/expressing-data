// reference
// https://github.com/sojamo/controlp5

import controlP5.*;

ControlP5 cp5;
Slider widthSlider;
Slider heightSlider;
Textfield rectNameField;

Square[] all_squares;
int squares_index;

void setup() {
  size(400, 400);
  noStroke();

  /* load data */
  all_squares = new Square[3];
  all_squares[0] = new Square(225, 225, "Square");
  all_squares[1] = new Square(75, 150, "Vertical");
  all_squares[2] = new Square(150, 75, "Horizontal");
  squares_index = 0;

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
    .setValue(all_squares[squares_index].rectWidth)
    .setRange(0, 300)
    .setNumberOfTickMarks(5); // only allow for 5 stops
  // restrict user from changing the value
  widthSlider.lock();

  // setup slider to control rectangle height
  heightSlider = cp5.addSlider("height")
    .setPosition(295, 25)
    .setSize(100, 15)
    .setId(2)
    .setValue(all_squares[squares_index].rectHeight)
    .setRange(0, 300);
  // restrict user from changing the value
  heightSlider.lock();

  // setup text input, hit enter key to trigger event
  rectNameField = cp5.addTextfield("rectName")
    .setPosition(295, 45)
    .setSize(100, 25)
    .setFont(font)
    .setId(3)
    .setValue(all_squares[squares_index].rectName)
    .setFocus(true)
    .setAutoClear(false)
    .setColor(color(255, 255, 255));
  // restrict user from changing the value
  rectNameField.lock();

  // create a new button with name 'randomize'
  cp5.addButton("prev")
    .setPosition(295, 75)
    .setSize(40, 15)
    .setId(4);
  cp5.addButton("next")
    .setPosition(355, 75)
    .setSize(40, 15)
    .setId(5);
}

void draw() {
  background(255);
  // draw rectangle
  fill(0);
  rect(50, 50, all_squares[squares_index].rectWidth, all_squares[squares_index].rectHeight);
  // draw text label
  fill(255);
  textAlign(CENTER);
  text(all_squares[squares_index].rectName, 50 + all_squares[squares_index].rectWidth/2, 50 + all_squares[squares_index].rectHeight/2);
}


void controlEvent(ControlEvent theEvent) {
  /* events triggered by controllers are automatically forwarded to 
   the controlEvent method. by checking the id of a controller one can distinguish
   which of the controllers has been changed.
   */
  println("got a control event from controller with id "+theEvent.getController().getId());
  switch(theEvent.getController().getId()) {
    case(4):
    // udpate object index
    if(squares_index > 0){
      squares_index--;
    }
    else{
      squares_index = 2;
    }
    // sync controlP5 interface
    widthSlider.setValue(all_squares[squares_index].rectWidth);
    heightSlider.setValue(all_squares[squares_index].rectHeight);
    rectNameField.setValue(all_squares[squares_index].rectName);
    break;
    case(5):
    // udpate object index
    if(squares_index < 2){
      squares_index++;
    }
    else{
      squares_index = 0;
    }
    // sync controlP5 interface
    widthSlider.setValue(all_squares[squares_index].rectWidth);
    heightSlider.setValue(all_squares[squares_index].rectHeight);
    rectNameField.setValue(all_squares[squares_index].rectName);
    break;
  }
}