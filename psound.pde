// sound
Minim minim;
AcidBass sound;
Sequence seq;

// Permutations!
Permutator permutator;
ArrayList<Sn> permutations;
Sn base;
Sn circulate;
Sn switchBack;
Sn halfSwitch;
Sn quarterSwitch;

// params to controll sounds
int current = 0;
int currentPattern = 0;
boolean willChange = false;

// UI
Knob moogFreqKnob;
Knob moogRezKnob;
Knob bpmKnob;
Knob volumeKnob;

Button startButton;
Button stopButton;
Button nextButton;
Button prevButton;
Button nextPatternButton;
Button prevPatternButton;
ToggleButton muteToggleButton;

// patterns(in Hz)
float[][] patterns = {
  {193.7, 261.6, 329.6, 349.2, 392.0, 440.0, 493.9, 523.3},
  {55, 220, 82.4, 0, 110, 55, 82.4, 0},
  {100, 320, 180, 100, 280, 100, 180, 230},
};

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
  mm.add(base);
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
  seq = new Sequence(patterns[0]);
  seq.setSn(mm.get(0));
  seq.setBPM(60);

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
  // Knob
  //
  moogFreqKnob = new Knob("Freq", 2000, 0, 10000);
  moogRezKnob = new Knob("Rez", 0.9, 0, 1);
  bpmKnob = new Knob("BPM", 120, 0, 300);
  volumeKnob = new Knob("Volume", 1, 0, 1);
  
  //
  // Button
  //
  startButton = new Button(this, "Start", 50, 660, 100, 60);
  stopButton = new Button(this, "Stop", 180, 660, 100, 60);
  nextButton = new Button(this, "→", 415, 245, 30, 30);
  prevButton = new Button(this, "←", 50, 245, 30, 30);
  nextPatternButton = new Button(this, "Next", 650, 720, 120, 40);
  prevPatternButton = new Button(this, "Previous", 520, 720, 120, 40);
  muteToggleButton = new ToggleButton(this, "Mute", false, 310, 660, 100, 60);
  
  //
  // P5
  //
  size(800, 800);
  background(255);
}

void draw() {    
  // update sound params
  sound.setMoogFrequency(moogFreqKnob.value);
  sound.setMoogResonance(moogRezKnob.value);
  
  // update permutator params
  permutator.setBPM(bpmKnob.value);
  if(!muteToggleButton.value) {
    permutator.setAmplitude(volumeKnob.value);
  }
  
  // visualize
  background(0);
  stroke(255);
  seq.draw(0, 0, width, 200);

  // right side
  permutator.drawCurrentPermutations(510, 540);
  volumeKnob.draw(550, 300, 80);
  bpmKnob.draw(700, 300, 80);
  moogFreqKnob.draw(550, 430, 80);
  moogRezKnob.draw(700, 430, 80);
  
  // sound pattern area
  textSize(18);
  text("Change Sound Pattern", 510, 700);
  prevPatternButton.draw();
  nextPatternButton.draw();
  
  // left side
  prevButton.draw();
  nextButton.draw();
  
  translate(0, 40);
  
  permutator.draw(50, 250, 400, 200);
  startButton.draw();
  stopButton.draw();
  muteToggleButton.draw();
}

void keyPressed() {
  if(keyCode == RIGHT) {
    permutator.next();
  } else if(keyCode == LEFT) {
    permutator.previous();
  }
}

void mousePressed() {
  moogFreqKnob.mousePressed(mouseX, mouseY);
  moogRezKnob.mousePressed(mouseX, mouseY);
  bpmKnob.mousePressed(mouseX, mouseY);
  volumeKnob.mousePressed(mouseX, mouseY);
  startButton.mousePressed(mouseX, mouseY);
  stopButton.mousePressed(mouseX, mouseY);
  muteToggleButton.mousePressed(mouseX, mouseY);
  nextButton.mousePressed(mouseX, mouseY);
  prevButton.mousePressed(mouseX, mouseY);
  nextPatternButton.mousePressed(mouseX, mouseY);
  prevPatternButton.mousePressed(mouseX, mouseY);
}

void mouseReleased() {
  moogFreqKnob.mouseReleased(mouseX, mouseY);
  moogRezKnob.mouseReleased(mouseX, mouseY);
  bpmKnob.mouseReleased(mouseX, mouseY);
  volumeKnob.mouseReleased(mouseX, mouseY);
  startButton.mouseReleased(mouseX, mouseY);
  stopButton.mouseReleased(mouseX, mouseY);
  muteToggleButton.mouseReleased(mouseX, mouseY);
  nextButton.mouseReleased(mouseX, mouseY);
  prevButton.mouseReleased(mouseX, mouseY);
  nextPatternButton.mouseReleased(mouseX, mouseY);
  prevPatternButton.mouseReleased(mouseX, mouseY);

}

void onButtonEvent(String name, int mx, int my, boolean isPressed) {
  if(name == "Start") {
    permutator.startSeq();
  } else if(name == "Stop") {
    permutator.stopSeq();
  } else if(name == "Mute") {
    
    if(muteToggleButton.value) {
      permutator.mute();
    } else {
      permutator.unmute();
    }
    
  } else if(name == "→" && isPressed) {
    permutator.next();
  } else if(name == "←" && isPressed) {
    permutator.previous();
  } else if(name == "Next" && isPressed) {
    currentPattern = (currentPattern+1)%patterns.length;
    permutator.setFrequences(patterns[currentPattern]);
  } else if(name == "Previous" && isPressed) {
    currentPattern = (currentPattern-1+patterns.length)%patterns.length;
    permutator.setFrequences(patterns[currentPattern]);
  }
  
}
