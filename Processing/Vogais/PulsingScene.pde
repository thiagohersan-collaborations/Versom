public class PulsingScene implements Scene {
  private ArrayList<PhraseObject> theObjects;
  private Minim myMinim;
  private AudioInput audioIn;
  private AudioInAverage audioAverage;

  public PulsingScene(Minim mm_) {
    myMinim = mm_;
    audioIn = myMinim.getLineIn(Minim.STEREO, 2048, 48000);
    audioAverage = new AudioInAverage();
    audioIn.addListener(audioAverage);

    theObjects = new ArrayList<PhraseObject>();
    for (int i=0; i<20; i++) {
      this.addObject("O");
    }
  }

  public void update() {
    for (int i=theObjects.size()-1; i>=0; i--) {
      theObjects.get(i).update();
      if (theObjects.get(i).isAlive == false) {
        theObjects.remove(i);
      }
      else {
        theObjects.get(i).setSize(map(audioAverage.getAverage(), 0, 1.0, 32, 500));
      }
    }
  }

  public void draw() {
    for (int i=theObjects.size()-1; i>=0; i--) {
      theObjects.get(i).draw();
    }
  }

  public void addObject(String phrase_) {
    theObjects.add(new PhraseObject(new PVector(random(width/8, width*7/8), random(height/8, height*7/8)), new PVector(0, 0), phrase_, 32));
  }

  public void stop() {
    audioIn.close();
    myMinim.stop();
  }
}

