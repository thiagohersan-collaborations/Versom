import controlP5.*;
import oscP5.*;
import netP5.*;

ControlP5 cp5;
ControlSlice[] cs = new ControlSlice[3];
int NUM_SLICES = 3;

void setup() {
  size(500, 600);
  background(0);
  PFont font = createFont("arial", 20);

  cp5 = new ControlP5(this);
  for (int i=0; i<NUM_SLICES; i++) {
    if (i==0) {
      cs[i] = new ControlSlice(cp5, i, "rainScene", new PVector(0, 0), new PVector(500, 200));
      cs[i].addSlider();
    }
    else {
      cs[i] = new ControlSlice(cp5, i, "rainScene", new PVector(0, cs[i-1].getPos().y+cs[i-1].getDim().y), new PVector(500, 200));
    }
  }
}

void draw() {
  background(0);

  for (int i=0, rv=200; i<NUM_SLICES; i++,rv-=50) {
    fill(rv, 11, 11);  
    rect(cs[i].getPos().x, cs[i].getPos().y, cs[i].getDim().x, cs[i].getDim().y);
  }
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

