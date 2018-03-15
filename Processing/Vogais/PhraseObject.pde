public class PhraseObject {
  private PVector pos;
  private PVector vel;
  private PVector acc;
  private String phrase;
  private color myColor;
  private float mySize;
  private PFont myFont;

  public boolean isAlive;
  private long timeLeft;
  private long lastUpdate;
  private int myAlpha;

  private float targetSize;

  PhraseObject(PVector pos_, PVector vel_, String p_, float s_) {
    this(pos_, vel_, new PVector(1, 1), p_, s_, -1);
    //myAlpha = 255;
  }

  PhraseObject(PVector pos_, PVector vel_, String p_, float s_, long tl_) {
    this(pos_, vel_, new PVector(0, 0), p_, s_, tl_);
  }

  // full blown fucker...
  PhraseObject(PVector pos_, PVector vel_, PVector acc_, String p_, float s_, long tl_) {
    mySize = s_;
    targetSize = s_;
    myFont = createFont("Helvetica", mySize);
    isAlive = true;
    timeLeft = tl_;
    lastUpdate = millis();
    myColor = #000000;
    // only fade out
    myAlpha = 255;
    // init
    pos = new PVector();
    vel = new PVector();
    acc = new PVector();

    pos.set(pos_);
    vel.set(vel_);
    acc.set(acc_);
    phrase = p_;
  }

  public float getWidth() {
    textSize(mySize);
    return textWidth(phrase);
  }
  public float getHeight() {
    textSize(mySize);
    return (mySize) * (phrase.split("\n").length);
  }
  public PVector getPos() {
    return pos;
  }

  public void setSize(float s_) {
    targetSize = s_;
  }

  public void update() {
    // update vel
    //    not really how vel and acc work in real life... but oh well...
    vel.mult(acc);
    // update pos
    pos.add(vel);
    // check pos
    isAlive = ((pos.x<width) && (pos.x>(0-getWidth())) && (pos.y<(height+mySize)) && (pos.y>(0-getHeight())));
    // check time
    if (timeLeft > 0) {
      timeLeft -= (millis()-lastUpdate);
      isAlive &= (timeLeft>0);
    }

    // update acc
    //acc.mult(0.8);

    // update alpha/color
    if ((timeLeft > 0) && (timeLeft < 2000)) {
      myAlpha = (int)map(timeLeft, 2000, 0, 255, 0);
    }

    // update size
    if (mySize != targetSize) {
      mySize = mySize*0.9 + targetSize*0.1;
    }

    lastUpdate = millis();
  }

  public void draw() {    
    fill(myColor, myAlpha);
    textSize(mySize);
    textLeading(mySize+1);
    text(phrase, pos.x, pos.y);
  }
}

