public class RunningObject {
  private PVector pos, vel;
  private String phrase;
  private float fSize;
  ArrayList<PhraseObject> theList;
  
  RunningObject(PVector pos_, PVector vel_, String s_, float f_){
    fSize = f_;
    pos = new PVector();
    pos.set(pos_);
    vel = new PVector();
    vel.set(vel_);
    phrase = s_;
    theList = new ArrayList<PhraseObject>();
    
    theList.add(new PhraseObject(pos, vel, phrase, fSize));
  }

  RunningObject(String s_){
    this(new PVector(random(width),random(height),0),s_,32);
  }
  RunningObject(PVector pos_, String s_){
    this(pos_,s_,32);
  }
  RunningObject(PVector pos_, String s_, float f_){
    this(pos_, new PVector(random(-5,5), random(-5,5)), s_, f_);
  }

  public void update(){
    // update and clean up phrases
    for(int i=theList.size()-1; i>=0; i--) {
      theList.get(i).update();
      if(theList.get(i).isAlive == false){
        theList.remove(i);
      }
    }
    
    // fire new phrase, vertically
    PhraseObject lastAdded = (theList.size()>0)?(theList.get(theList.size()-1)):(null);
    if(lastAdded != null && ((abs(lastAdded.getPos().x - pos.x) > lastAdded.getWidth()) || (abs(lastAdded.getPos().y - pos.y) > lastAdded.getHeight()))){
      theList.add(new PhraseObject(pos, vel, phrase, fSize));
    }
    
  }
  public void draw(){
    for(int i=theList.size()-1; i>=0; i--) {
      theList.get(i).draw();
    }
  }
}

