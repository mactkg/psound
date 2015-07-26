class Sequence extends Thread {
  Sn converter;
  Sound sound;
  
  float[] freqs;
  int count;
  float bpm;
  int beatMs;
  double lastUpdateMs;

  Sequence(float[] f) {
    freqs = f;
    int[] d = {
      0, 1, 2, 3, 4, 5, 6, 7
    };
    converter = new Sn(16, d);
    setBPM(120);
    
    thread("loop");
  }

  void setSn(Sn sn) {
    converter = sn;
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
        //brabrabra...
        try {
          sound.setFrequency(getCurrentFreq(count));
        } catch(Exception e) {
          println(e);
        }
        println(beatMs);
        
        count = (count+1)%freqs.length;
      }
    }
  }
  
  void draw() {
    sound.draw();
  }

  void setSound(Sound s) {
    sound = s;
  }

  float[] appliedFreqs(Sn sn) {
    float[] data = new float[freqs.length];

    for (int i = 0; i < sn.x.length; i++) {
      data[sn.x[i]] = freqs[i];
    }

    return data;
  }

  float getCurrentFreq(int tick) {
    return appliedFreqs(converter)[tick%freqs.length];
  }
  
  void setBPM(float _bpm) {
    bpm = _bpm;
    beatMs = int(60.0/bpm*1000);
  }
}

