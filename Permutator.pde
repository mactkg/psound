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
    seq.setSn(permutations.get(current));
    current = (current+1)%permutations.size();
  }
 
  void drawSequence(int x, int y, float[] array) {
    pushMatrix();
    
    for(int i = 0; i < array.size(); i++) {
      
    }
    
    popMatrix();
  }
  
  void getHeight() {
    
  }
  
  void getWidth() {
    
  }
}
