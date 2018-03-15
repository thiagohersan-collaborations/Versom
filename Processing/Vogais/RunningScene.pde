public class RunningScene implements Scene {
  private ArrayList<RunningObject> theObjects;

  RunningScene() {
    theObjects = new ArrayList<RunningObject>();
    PVector currPos = new PVector(width/4, height/4);

    // add a horizontal running scene
    while (currPos.y<height*3/4) {
      float h = currPos.y;
      String phrase = "AAAAAAA\nAAAAAAA";
      float ts = random(20, 32);
      textSize(ts);
      float v = ((random(2)<1)?1:-1)*random(2, 5);
      float ix = (v<0)?width:-textWidth(phrase);
      float iy = ts * (phrase.split("\n").length);
      // even when there are multiple lines, processing uses the bottom left of the first line to draw text
      //   that's why we have all this math here. ts is the position of the first line
      //   iy is the height of the text
      theObjects.add(new RunningObject(new PVector(ix, h+ts), new PVector(v, 0), phrase, ts));
      currPos.y += iy;
    }
    ///////////////////
    // add a vertical running scene
    while ( (currPos.x<width*3/4)) {
      float w = currPos.x;
      String phrase = "EE\nEE\nEE";
      float ts = random(20, 32);
      textSize(ts);
      float v = ((random(2)<1)?1:-1)*random(2, 5);
      float th = ts * (phrase.split("\n").length);
      float iy = (v<0)?height+ts:0-th;
      float tw = textWidth(phrase);
      // even when there are multiple lines, processing uses the bottom left of the first line to draw text
      //   that's why we have all this math here. ts is the position of the first line
      //   iy is the height of the text
      theObjects.add(new RunningObject(new PVector(w, iy), new PVector(0, v), phrase, ts));
      currPos.x += tw;
    }
  }

  public void update() {
    for (int i=0; i<theObjects.size(); i++) {
      theObjects.get(i).update();
    }
  }
  public void draw() {
    for (int i=0; i<theObjects.size(); i++) {
      theObjects.get(i).draw();
    }
  }

  // TODO: add to running scene
  public void addObject(String phrase_) {
  }

  public void addObject(String phrase_, float fontSize, float vel, boolean goHorizontal) {
  }
}

