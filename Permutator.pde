class Permutator {
  ArrayList<Sn> permutations;
  Sequence seq;
  int current;
  
  Permutator(ArrayList<Sn> perm, Sequence s) {
    permutations = perm;
    seq = s;
  }
  
  void previous() {
    current = (current+permutations.size()-1)%permutations.size();
    seq.setSn(permutations.get(current));
  }
  
  void next() {
    current = (current+1)%permutations.size();
    seq.setSn(permutations.get(current));
  }
  
  void draw(int x, int y, int w, int h) {
    pushMatrix();
    pushStyle();
    
    for(int i = 0; i < permutations.size(); i++) {
      int py = y + i*(10+2);
      
      if(i == current) {
        drawSequence(x, py, w, 10, seq.getCurrentFreqs(), seq.count);
      } else {
        drawSequence(x, py, w, 10, seq.getAppliedFreqs(permutations.get(i)), -1);  
      }
    }
    
    popStyle();
    popMatrix();
  }
 
  void drawSequence(int x, int y, int w, int h, float[] array, int available) {
    pushMatrix();
    pushStyle();
    
    translate(x, y);
    
    colorMode(HSB, 360, 100, 100);
    
    float margin = 2;
    float cw = (w - margin*(array.length+1))/array.length;
    
    float max = -1;
    for(int i = 0; i < array.length; i++) {
      max = max(max, array[i]);
    }
    
    for(int i = 0; i < array.length; i++) {
      if(i == available) {
        fill(43, 82, 98);
        stroke(255);
      } else {
        fill(0, 0, array[i]/max*100);
        stroke(255);  
      }
      
      rect(i*(margin+cw) + margin, 0, cw, h);  
    }
    
    popStyle();
    popMatrix();
  }
  
  void drawCurrentPermutations(int x, int y) { 
    pushMatrix();
    pushStyle();
    
    // title
    translate(x, y);
    textSize(18);
    text("Current Permutation", 0, 0);
    
    // permutation
    translate(15, 40);
    textSize(30);
    Sn cp = permutations.get(current);
    
    for(int i = 0; i < cp.x.length; i++) {
      text(i, i*25, 0);
      line(i*25 + 10, 10, cp.x[i]*25 + 10, 50);
      text(i, cp.x[i]*25, 80);
    }
    
    popStyle();
    popMatrix();
  }

  void setBPM(float bpm) {
    seq.setBPM(bpm);
  }
  
  void setAmplitude(float amp) {
    seq.setAmplitude(amp);
  }
  
  void unmute() {
    seq.unmute();
  }
  
  void mute() {
    seq.mute();
  }
  
  void startSeq() {
    seq.startSeq();
  }
  
  void stopSeq() {
    seq.stopSeq();
  }
}
