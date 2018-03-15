public class PhysicalScene implements Scene {
  private ArrayList<PhysicalObject> shapes;

  private PBox2D mBox2d;

  public PhysicalScene(PBox2D b2d) {
    mBox2d = b2d;
    // initialize box2d physics world
    mBox2d.createWorld();
    mBox2d.setGravity(0, -20);

    shapes = new ArrayList<PhysicalObject>();
    for (int i=0; i<1; i++) {
      this.addObject("iii");
    }
  }

  public void update() {
    // important
    mBox2d.step();
    // clean up the objects that are done/dead
    for (int i = shapes.size()-1; i>=0; i--) {
      if (shapes.get(i).done()) {
        shapes.remove(i);
      }
    }
  }

  // draw all flying objects
  public void draw() {
    for (int i = shapes.size()-1; i>=0; i--) {
      shapes.get(i).draw();
    }
  }

  public void addObject(String phrase_) {
    shapes.add(new PhysicalObject(mBox2d, phrase_));
  }
}

