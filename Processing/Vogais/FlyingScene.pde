public class FlyingScene implements Scene {
  private ArrayList<PhraseObject> theObjects;
  private final int NUM_OBJS = 50;

  public FlyingScene() {
    theObjects = new ArrayList<PhraseObject>();
    for (int i=0; i<NUM_OBJS; i++) {
      this.addObject("U");
    }
  }

  public void update() {
    for (int i=theObjects.size()-1; i>=0; i--) {
      theObjects.get(i).update();
      if (theObjects.get(i).isAlive == false) {
        theObjects.remove(i);
        this.addObject("U");
      }
    }
  }

  public void draw() {
    for (int i=theObjects.size()-1; i>=0; i--) {
      theObjects.get(i).draw();
    }
  }

  public void addObject(String phrase_) {
    PVector v = new PVector(random(-5, 5), random(-5, 5));
    PVector a = new PVector(0.98, 0.98);
    PhraseObject tpo = new PhraseObject(new PVector(random(width/8, width*7/8), random(height/8, height*7/8)), v, a, phrase_, 90, (long)random(15, 50)*200);
    tpo.setSize(32);
    theObjects.add(tpo);
  }
}

