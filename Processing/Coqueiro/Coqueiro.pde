import processing.opengl.*;

import pbox2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

PBox2D box2d;

ArrayList<FixedBoundary> boundaries;
ArrayList<AShape> shapes;

PFont mFont;
String tmpWord;

void setup() {
  size(640, 360, OPENGL);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  shapes = new ArrayList<AShape>();
  boundaries = new ArrayList<FixedBoundary>();

  // Add a fixed boundary
  boundaries.add(new FixedBoundary(width/2, height-5, width+80, 10, 0));

  // setup font
  mFont = createFont("Helvetica", 64);
  textFont(mFont);
  textSize(24);

  tmpWord = "";
}

void draw() {
  background(255);
  box2d.step();

  // report fps
  fill(0);
  textSize(24);
  text(frameRate, width*8/10, 30);

  // show the boundaries
  for (FixedBoundary fb:boundaries) {
    fb.display();
  }

  // show shape objects
  for (AShape as:shapes) {
    as.display();
  }

  // clean up the objects
  for (int i = shapes.size()-1; i>=0; i--) {
    AShape as = shapes.get(i);
    if (as.done()) {
      shapes.remove(i);
    }
  }
}

void keyReleased() {
  if (! ((key == ' ') || (key == BACKSPACE) || (key == TAB) || (key == ENTER) || (key == RETURN) || (key == ESC) || (key == DELETE) || (key == CODED) ) ) {
    //release a letter
    shapes.add(new LetterShape(key));
    tmpWord = tmpWord+key;
  }
  else if ((key == ' ') && (!tmpWord.equals(""))) {
    tmpWord = tmpWord+key;
  }
  else if (((key == ENTER) || (key == RETURN)) && (!tmpWord.equals(""))) {
    // release a word
    shapes.add(new WordShape(tmpWord));
    tmpWord = "";
  }
}

void mouseReleased() {
  //release a word
  shapes.add(new WordShape());
}

