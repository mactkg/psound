Minim minim;
AcidBass sound;
Permutator permutator;
Sequence seq;

ArrayList<Sn> permutations;
Sn base;
Sn circulate;
Sn switchBack;
Sn halfSwitch;
Sn quarterSwitch;

int current = 0;
boolean willChange = false;

void setup() {
  //
  // Sn HACK
  //
  
  int[] b = {0, 1, 2, 3, 4, 5, 6, 7};
  int[] c = {7, 0, 1, 2, 3, 4, 5, 6};
  int[] hs = {4, 5, 6, 7, 0, 1, 2, 3};
  int[] qs = {6, 7, 4, 5, 2, 3, 0, 1};
  
  base = new Sn(8, b);
  circulate = new Sn(8, c);
  halfSwitch = new Sn(8, hs);
  quarterSwitch = new Sn(8, qs);
  
  ArrayList<Sn> mm=new ArrayList<Sn>();
  mm.add(prod(base, circulate));
  mm.add(prod(base, halfSwitch));
  mm.add(prod(base, quarterSwitch));
  
  for(int i=0;i<mm.size();i++){
    print(i,":");
    mm.get(i).print2();
  }
  println("===========================");
  
  generateGroup(mm,0);
  for(int i=0;i<mm.size();i++){
    print(i,":");
    mm.get(i).print2();
  }
  
  //
  // Sequence
  //
  //float[] test = {100, 320, 180, 100, 280, 100, 180, 230};
  //float[] test = {261.6, 193.7, 329.6, 349.2, 392.0, 440.0, 493.9, 523.3};
  float[] test = {55, 220, 82.4, 0, 110, 55, 82.4, 0};
  seq = new Sequence(test);
  seq.setSn(mm.get(0));
  seq.setBPM(120);

  //
  // Sound
  //
  minim = new Minim(this);
  sound = new AcidBass(minim);
  seq.setSound(sound);
  seq.start();
  
  //
  // Permutator
  //
  permutator = new Permutator(mm, seq);
  
  //
  // P5
  //
  size(1200, 800);
  background(255);
}

void draw() {  
  float freq = constrain( map( mouseX, 0, width, 200, 12000 ), 200, 12000 );
  float rez  = constrain( map( mouseY, height, 0, 0, 1 ), 0, 1 );
  
  sound.setMoogFrequency(freq);
  sound.setMoogResonance(rez);
  
  // visualize
  background(0);
  stroke(255);

  seq.draw();
}

void keyPressed() {
  if(keyCode == RIGHT) {
    permutator.next();
  } else if(keyCode == LEFT) {
    permutator.previous();
  }
}
