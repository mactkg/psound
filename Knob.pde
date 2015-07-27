class Knob {
  String name;
  float value;
  float minValue, maxValue;
  
  boolean isPressed;
  float pressedX, pressedY, pressedValue;
  float placedX, placedY, placedR;
  
  Knob(String str, float defaultValue, float min, float max) {
    name = str;
    value = defaultValue;
    minValue = min;
    maxValue = max;
  }
  
  void draw(float x, float y, float r) {
    placedX = x;
    placedY = y;
    placedR = r;
    
    if(isPressed) {
      float d = (maxValue - minValue) / 500;
      float v = dist(pressedX, pressedY, mouseX, mouseY)*d;
      if(pressedY < mouseY) {
        v = -v;
      }
      
      value = constrain(pressedValue + v, minValue, maxValue);
    }
    
    pushMatrix();
    pushStyle();
    
    ellipseMode(CENTER);
    translate(x, y);
    
    fill(200);
    stroke(80);
    arc(0, 0, r, r, TWO_PI/10+PI/2, TWO_PI*9/10+PI/2, CHORD);

    
    float p = -map(value, minValue, maxValue, TWO_PI/10, TWO_PI*9/10);
    strokeWeight(4);
    noFill();
    line(0, 0, sin(p)*r/2, cos(p)*r/2);

    strokeWeight(3);
    stroke(251,192,45);
    arc(0, 0, r, r, TWO_PI/10+PI/2, -p+PI/2, OPEN);
    
    textAlign(CENTER);
    textSize(18);
    text(name, 0, r/2+15);
    textSize(14);
    text(value, 0, r/2+30);
    
    popStyle();
    popMatrix();
  }
  
  void mousePressed(float mx, float my) {
    if(isPressed(mx, my)) {
      isPressed = true;
      pressedValue = value;
      pressedX = mx;
      pressedY = my;
    }
  }
  
  void mouseReleased(float mx, float my) {
    isPressed = false;
    pressedX = mx;
    pressedY = my;
  }
  
  boolean isPressed(float mx, float my) {
    if(dist(placedX, placedY, mx, my) < placedR/2) {
      return true;
    } else {
      return false;
    }
  }
}
