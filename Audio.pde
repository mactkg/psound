import promidi.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

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
  
  void draw() {
    for( int i = 0; i < out.bufferSize() - 1; i++ )
    {
      float x1 = map( i, 0, out.bufferSize(), 0, width );
      float x2 = map( i+1, 0, out.bufferSize(), 0, width  );
  
      line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
      line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
    }
  }
  
  void setFrequency(float freq) throws Exception {
    throw new Exception("Please impl here");
  }
  
  int bufferSize() {
    return out.bufferSize();
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
  
  void setAmplitude(int amp) {
    osc.setAmplitude(amp);
  }
  
  void stop() {
    osc.setAmplitude(0);
  }
  
  void start() {
    osc.setAmplitude(1);
  }
}

