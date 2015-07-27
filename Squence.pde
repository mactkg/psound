class Sequence extends Thread {
  Sn converter;
  Sound sound;
  
  float[] freqs;
  int count;
  float bpm;
  int beatMs;
  double lastUpdateMs;
  boolean isWorking;

  Sequence(float[] f) {
    isWorking = true;
    freqs = f;
    int[] d = {
      0, 1, 2, 3, 4, 5, 6, 7
    };
    //converter = new Sn(8, d);
    setBPM(120);
    
    thread("loop");
  }

  void setSn(Sn sn) {
    converter = sn;
  }
  
  void setFrequences(float[] f) {
    freqs = f;
  }
  
  void start() {
    println("start thread");
    super.start();
  }

  void run() {
    while(true) {
      double ms = millis();
      if(ms - lastUpdateMs > beatMs/2) {
        lastUpdateMs = ms;
        if(isWorking) {
          count = (count+1)%freqs.length;
        }
        
        try {
          sound.setFrequency(getCurrentFreq(count));
        } catch(Exception e) {
          println(e);
        }
        //println(beatMs);
      }
    }
  }
  
  void draw(float x, float y, float w, float h) {
    sound.draw(x, y, w, h);
  }

  void setSound(Sound s) {
    sound = s;
  }
 
  void setBPM(float _bpm) {
    bpm = _bpm;
    beatMs = int(60.0/bpm*1000);
  }
  
  void setAmplitude(float amp) {
    try{
      sound.setAmplitude(amp);
    } catch(Exception e){
    }
  }

  float[] getAppliedFreqs(Sn sn) {
    float[] data = new float[freqs.length];

    for (int i = 0; i < sn.x.length; i++) {
      data[sn.x[i]] = freqs[i];
    }
    
    return data;
  }

  float[] getCurrentFreqs() {
    return getAppliedFreqs(converter);
  }

  float getCurrentFreq(int tick) {
    return getAppliedFreqs(converter)[tick%freqs.length];
  }
  
  void unmute() {
    try{
      sound.unmute();
    } catch(Exception e) {
    }
  }
  
  void mute() {
    try{
      sound.mute();
    } catch(Exception e) {
    }
  }
  
  void stopSeq() {
    isWorking = false;
  }
  
  void startSeq() {
    isWorking = true;
  }
}

