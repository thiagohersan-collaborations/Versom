import controlP5.*;
import oscP5.*;
import netP5.*;

ControlP5 cp5;

ControlSlice cs, cs2, cs3;

void setup() {
  size(500, 600);
  background(0);
  PFont font = createFont("arial", 20);

  cp5 = new ControlP5(this);
  cs = new ControlSlice(cp5, 0, "rainScene", new PVector(0, 0), new PVector(500, 200));
  cs.addSlider();
  cs2 = new ControlSlice(cp5, 1, "rainScene", new PVector(0, cs.getPos().y+cs.getDim().y), new PVector(500, 200));
  cs3 = new ControlSlice(cp5, 2, "rainScene", new PVector(0, cs2.getPos().y+cs2.getDim().y), new PVector(500, 200));
}

void draw() {
  background(0);
  fill(200, 11, 11);
  rect(cs.getPos().x, cs.getPos().y, cs.getDim().x, cs.getDim().y);
  fill(150, 11, 11);
  rect(cs2.getPos().x, cs2.getPos().y, cs2.getDim().x, cs2.getDim().y);
  fill(100, 11, 11);
  rect(cs3.getPos().x, cs3.getPos().y, cs3.getDim().x, cs3.getDim().y);
}

void controlEvent(ControlEvent theEvent) {

  // reserve 100 controllers per scene/slice
  // get text field
  Textfield theTextController = cp5.get(Textfield.class, new String("text"+theEvent.getController().getId()/100));
  // TODO: might have to get some other shit too... like, options...

  // add button
  if (theEvent.getController().getName().toLowerCase().matches(".*add.*")) {
    // for all of them....
    String textBox = theTextController.getText();
    println(textBox);
    theTextController.clear();

    // specific stuff
    // first scene/slice
    if (theEvent.getController().getId()<100) {
      // send osc...
    }
    // second scene/slice
    else if (theEvent.getController().getId()<200) {
      // send osc...
    }
    // third scene/slice
    else if (theEvent.getController().getId()<300) {
      // send osc...
    }
  }

  // TODO: delete button
  else if (theEvent.getController().getName().toLowerCase().matches(".*del.*")) {
    println("delete"+ theEvent.getController().getId()/100);
  }

  // TODO: enable/disable button
  else if (theEvent.getController().getName().toLowerCase().matches(".*toggle.*")) {
    println("toggle"+ theEvent.getController().getId()/100+" = "+theEvent.getController().getValue());
  }

  // TODO: scene parameters??
}

