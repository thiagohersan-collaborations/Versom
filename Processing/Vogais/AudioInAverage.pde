class AudioInAverage implements AudioListener {
  private float[] left;
  private float[] right;
  private float sum;

  
  AudioInAverage(){
    left = null; 
    right = null;
    sum = 0;
  }
  
  synchronized void samples(float[] samp) {
    left = samp;
  }
  
  synchronized void samples(float[] sampL, float[] sampR) {
    left = sampL;
    right = sampR;
  }

  synchronized float getAverage(){
    float s = 0;
    for(int i=0; (left!=null)&&(i<left.length); i++) {
      s += abs(left[i]);
    }
    return (left != null)?(s/(float)left.length):(0);
  }
  
}
