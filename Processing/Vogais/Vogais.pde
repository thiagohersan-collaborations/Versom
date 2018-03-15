import processing.opengl.*;

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

RunningScene rs;
FlyingScene fs;
PulsingScene ps;
PhysicalScene pss;

// TODO: control panel
// TODO: OSC receive

void setup() {
  size(1024, 768);
  smooth();
  frameRate(60);

  fs = new FlyingScene();
  rs = new RunningScene();
  ps = new PulsingScene(new Minim(this));
  pss =  new PhysicalScene(new PBox2D(this));
}

void draw() {
  background(255);
  fs.update();
  rs.update();
  ps.update();
  pss.update();

  fs.draw();
  rs.draw();
  ps.draw();
  pss.draw();

  if (frameCount%100 == 0) {
    println(frameRate);
  }
}

void keyReleased() {
  String ts = "iiiiii";
  pss.addObject(ts.substring((int)random(6)));
}

void stop() {
  // always stop Minim before exiting.
  ps.stop();
  super.stop();
}

