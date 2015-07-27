import promidi.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

// sound base class
class Sound {
  Minim       minim;
  AudioOutput out;
  AudioBuffer left;
  AudioBuffer right;
  
  Sound(Minim m) {
    minim = m;
    out = m.getLineOut();
    left = out.left;
    right = out.right;
  }
  
  void draw(float x, float y, float w, float h) {
    pushMatrix();
    pushStyle();
    
    stroke(255);
    for( int i = 0; i < out.bufferSize() - 1; i++ )
    {
      float x1 = map( i, 0, out.bufferSize(), 0, w );
      float x2 = map( i+1, 0, out.bufferSize(), 0, w  );
      float yy = h/4;
  
      line( x1, yy + out.left.get(i)*yy, x2, yy + out.left.get(i+1)*yy);
      line( x1, 3*yy + out.right.get(i)*yy, x2, 3*yy + out.right.get(i+1)*yy);
    }
    
    noFill();
    stroke(255);
    rect(x, y, w-1, h-1);
    
    popStyle();
    popMatrix();
  }
  
  void setFrequency(float freq) throws Exception {
    throw new Exception("Please impl here");
  }
  
  int bufferSize() {
    return out.bufferSize();
  }
  
  void mute() throws Exception {
    throw new Exception("Please impl here");
  }
  
  void unmute() throws Exception {
    throw new Exception("Please impl here");
  }
  
  void setAmplitude(float amp)throws Exception  {
    throw new Exception("Please impl here");
  }
}


class AcidBass extends Sound {
  MidiIO      midiIO;
  Oscil       osc;
  MoogFilter  moog;
  

  AcidBass(Minim m) {
    super(m);
    moog = new MoogFilter(1200, 0.5);
    moog.type = MoogFilter.Type.LP;
    osc = new Oscil(440, 0.5f, Waves.SAW);
    osc.patch(moog).patch(out);
  }
  
  void setMoogFrequency(float freq) {
    moog.frequency.setLastValue(freq);
  }
  
  void setMoogResonance(float rez) {
    moog.resonance.setLastValue(rez);
  }
  
  void setFrequency(float freq) {
    osc.setFrequency(freq);
  }
  
  void setAmplitude(float amp) {
    osc.setAmplitude(amp);
  }
  
  void mute() {
    osc.setAmplitude(0);
  }
  
  void unmute() {
    osc.setAmplitude(1);
  }
}

