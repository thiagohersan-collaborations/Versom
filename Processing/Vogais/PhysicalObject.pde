
class PhysicalObject {
  private static final boolean DEBUG = false;

  PBox2D mBox2d;

  ArrayList<Body> bodies;
  ArrayList<Joint> joints;

  // and time of creation
  private long creationTime = -1;
  private static final int LIFE_PERIOD = 30000;

  // and word
  private String myString;
  private int myFontSize;
  private int textHeight, textHeight45;

  // Constructor
  PhysicalObject(PBox2D b2d, float x, float y, String s) {
    mBox2d = b2d;
    bodies = new ArrayList<Body>();
    joints = new ArrayList<Joint>();
    for (int i=0; i<s.length(); i++) {
      bodies.add(null);
    }

    myString = s;

    myFontSize = (int)random(24, 64);
    textHeight = myFontSize*2/3;

    makeBody(new Vec2(x, y));
    creationTime = millis();
  }
  PhysicalObject(PBox2D b2d, String s) {
    this(b2d, 20, height-30, s);
  }

  // This function removes the particle from the box2d world
  // must destroy joints before bodies
  void killBody() {
    // joints
    for (int i=0; i<joints.size(); i++) {
      Joint j = joints.get(i);
      mBox2d.world.destroyJoint(j);
    }
    // bodies
    for (int i=0; i<bodies.size(); i++) {
      Body b = bodies.get(i);
      mBox2d.world.destroyBody(b);
    }
  }

  // Is the particle ready for deletion?
  boolean done() {
    if ((millis() - creationTime) > LIFE_PERIOD) {
      killBody();
      return true;
    }

    // see if all the letters are off the screen
    for (int i=0; i<bodies.size(); i++) {
      Body b = bodies.get(i);
      // Let's find the screen position of the particle
      Vec2 pos = mBox2d.getBodyPixelCoord(b);
      // if there's a letter within bounds
      if ((pos.x > 0) || (pos.x < width)) {
        return false;
      }
    }
    // if we got here, then no letters within bounds, kill
    killBody();
    return true;
  }

  // Drawing the word
  void draw() {
    textSize(myFontSize);

    for (int i=0; i<bodies.size(); i++) {
      Body b = bodies.get(i);
      Fixture f = b.getFixtureList();
      PolygonShape ps = (PolygonShape) f.getShape();
      char myChar = myString.charAt(i);

      // We look at each body and get its screen position
      Vec2 pos = mBox2d.getBodyPixelCoord(b);
      // Get its angle of rotation
      float a = b.getAngle();

      // set alpha according to how much life it has left
      long tLeft = LIFE_PERIOD-(millis()-creationTime);
      int alphaVal = (int)((tLeft>(1500))?(255):(map(tLeft, 1500, 0, 255, 0)));

      if (DEBUG) {
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(-a);
        beginShape();
        fill(175, min(alphaVal, 120));
        stroke(0, min(alphaVal, 120));
        //println(vertices.length);
        // For every vertex, convert to pixel vector
        for (int j = 0; j < ps.getVertexCount(); j++) {
          Vec2 v = mBox2d.vectorWorldToPixels(ps.getVertex(j));
          vertex(v.x, v.y);
        }
        fill(175, alphaVal);
        stroke(0, alphaVal);
        endShape(CLOSE);
        popMatrix();
      }

      pushMatrix();
      translate(pos.x, pos.y);
      rotate(-a);
      stroke(0, alphaVal);
      fill(0, alphaVal);
      //translate(-textWidth(myChar)/2, textHeight/2-yOff);
      translate(-textWidth(myChar)/2, textHeight/2);
      //text(myString, 0, 0);
      text(myChar, 0, 0);
      popMatrix();
    }
  }

  // This function adds the shape
  void makeBody(Vec2 xy) {
    textSize(myFontSize);
    // iterate through word
    textHeight45 = textHeight*4/5;
    for (int i=(myString.length()-1); i >= 0; i--) {
      char myChar = myString.charAt(i);
      float cW = textWidth(myChar);
      int myOff = 0;
      //println(myChar);

      if ((myChar == 'g')||(myChar == 'j')||(myChar == 'p')||(myChar == 'q')||(myChar == 'y') ) {
        myOff += textDescent();
      }
      if ((myChar == 'a')||(myChar == 'e')||(myChar == 'o')||(myChar == 'u')||(myChar == 'o') ) {
        textHeight = textHeight45;
      }

      PolygonShape sd = new PolygonShape();
      Body cB;

      Vec2[] vertices = new Vec2[4];
      vertices[0] = mBox2d.vectorPixelsToWorld(new Vec2(-cW/2, -textHeight/2));
      vertices[1] = mBox2d.vectorPixelsToWorld(new Vec2(-cW/2, textHeight/2+myOff));
      vertices[2] = mBox2d.vectorPixelsToWorld(new Vec2(cW/2, textHeight/2+myOff));
      vertices[3] = mBox2d.vectorPixelsToWorld(new Vec2(cW/2, -textHeight/2));

      sd.set(vertices, vertices.length);

      // Define the body and make it from the shape
      BodyDef bd = new BodyDef();
      bd.type = BodyType.DYNAMIC;
      bd.position.set(mBox2d.coordPixelsToWorld(new Vec2(xy.x+i*2, xy.y)));
      cB = mBox2d.createBody(bd);
      cB.createFixture(sd, 1.0);
      cB.setAngularVelocity(0);

      Fixture tfx = cB.getFixtureList();
      tfx.setRestitution(0.4);
      tfx.setFriction(0.4);

      bodies.set(i, cB);

      //cB.setLinearVelocity(new Vec2(random(5, 12), random(30, 35)));
      Vec2 initVel = new Vec2(random(10, 15), random(32, 37));
      cB.setLinearVelocity(initVel);

      // for all except first
      if (i != (myString.length()-1)) {
        Body pB = bodies.get(i+1);
        // top anchor points
        Vec2 pbAT = new Vec2(pB.getWorldCenter().x-mBox2d.scalarPixelsToWorld(textWidth(myString.charAt(i+1))/2), 
        pB.getWorldCenter().y-mBox2d.scalarPixelsToWorld(textHeight/2));
        Vec2 cbAT = new Vec2(cB.getWorldCenter().x+mBox2d.scalarPixelsToWorld(textWidth(myString.charAt(i+0))/2), 
        cB.getWorldCenter().y-mBox2d.scalarPixelsToWorld(textHeight/2));
        // bottom anchor points
        Vec2 pbAB = new Vec2(pB.getWorldCenter().x-mBox2d.scalarPixelsToWorld(textWidth(myString.charAt(i+1))/2), 
        pB.getWorldCenter().y+mBox2d.scalarPixelsToWorld(textHeight/2));
        Vec2 cbAB = new Vec2(cB.getWorldCenter().x+mBox2d.scalarPixelsToWorld(textWidth(myString.charAt(i+0))/2), 
        cB.getWorldCenter().y+mBox2d.scalarPixelsToWorld(textHeight/2));

        DistanceJointDef jDefT = new DistanceJointDef();
        jDefT.initialize(cB, pB, cbAT, pbAT);
        jDefT.length = 0.2;
        jDefT.dampingRatio = 0.0;

        DistanceJointDef jDefB = new DistanceJointDef();
        jDefB.initialize(cB, pB, cbAB, pbAB);
        jDefB.length = 0.2;
        jDefB.dampingRatio = 0.0;

        joints.add(mBox2d.createJoint(jDefT));
        joints.add(mBox2d.createJoint(jDefB));
      }
    }
  }
}

