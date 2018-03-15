// PBox2D example

class LetterShape implements AShape {

  // We need to keep track of a Body
  Body body;

  // and time of creation
  private long creationTime = -1;
  private static final int LIFE_PERIOD = 10000;

  // and letter
  private char myChar;
  private static final int TEXT_H = 16;
  private float yOff;

  // Constructor
  LetterShape(float x, float y, char c) {
    myChar = c;
    yOff = 0;
    if ((myChar == 'b')||(myChar == 'd')) {
      //myH += textAscent();
    }
    if ((myChar == 'g')||(myChar == 'j')||(myChar == 'p')||(myChar == 'q')||(myChar == 'y') ) {
      yOff += textDescent();
    }


    // Add the box to the box2d world
    makeBody(new Vec2(x, y));
    creationTime = millis();
  }
  LetterShape(char c) {
    // hahahahhha
    //  leet ascii
    this(20, height-30, c);
  }
  LetterShape() {
    // hahahahhha
    //  leet ascii
    this(20, height-30, (char)((int)(random(0, 2))*32+(int)map((int)random(0, 26), 0, 25, 'A', 'Z')));
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.world.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    if ((millis() - creationTime) > LIFE_PERIOD) {
      killBody();
      return true;
    }
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is the center of the object off the screen by 15 pixels
    if ((pos.x > (width+15)) || (pos.x < -15)) {
      killBody();
      return true;
    }
    return false;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    //Fixture f = body.getFixtureList();
    //PolygonShape ps = (PolygonShape) f.getShape();

    // set alpha according to how much life it has left
    long tLeft = LIFE_PERIOD-(millis()-creationTime);
    int alphaVal = (int)((tLeft>(1500))?(255):(map(tLeft, 1500, 0, 255, 0)));

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    stroke(0, alphaVal);
    /*
    beginShape();
     //println(vertices.length);
     // For every vertex, convert to pixel vector
     for (int i = 0; i < ps.getVertexCount(); i++) {
     Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
     vertex(v.x, v.y);
     
     // for debug
     //fill(255, 0, 0, 255);
     //ellipse(v.x, v.y, 8, 8);
     }
     
     fill(175, alphaVal);
     stroke(0, alphaVal);
     endShape(CLOSE);
     */
    fill(0, alphaVal);
    translate(-textWidth(myChar)/2, TEXT_H/2-yOff);
    textSize(24);
    text(myChar, 0, 0);
    popMatrix();
  }

  // This function adds the shape
  void makeBody(Vec2 center) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float tf = textWidth(myChar);

    Vec2[] vertices = new Vec2[4];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-tf/2, -TEXT_H/2));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(-tf/2, TEXT_H/2));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(tf/2, TEXT_H/2));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(tf/2, -TEXT_H/2));

    sd.set(vertices, vertices.length);

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    body.createFixture(sd, 1.0);

    // Give it some initial velocity
    body.setLinearVelocity(new Vec2(random(5, 12), random(30, 35)));
    body.setAngularVelocity(0);

    Fixture tfx = body.getFixtureList();
    tfx.setRestitution(0.4);
    tfx.setFriction(0.4);
  }
}

