class Button {
  String name;
  int x, y, w, h;
  color background, pressed, stroke;
  boolean isPressed;
  PFont font;
  
  Button(String _name, int _x, int _y, int _w, int _h) {
    name = _name;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    background = color(30);
    pressed    = color(100);
    stroke     = color(255);
    
    font = loadFont("font.vlw");
  }
  
  void draw() {
    pushMatrix();
    pushStyle();
    
    if(isPressed) {
      fill(pressed);
    } else {
      fill(background);
    }
    stroke(stroke);
    rect(x, y, w, h);
    
    rectMode(CENTER);
    textFont(font);
    text(name, x+w/2, y+h/2);
    
    popStyle();
    popMatrix();
  };
  
  void mousePressed(int mx, int my) {
    if(isInside(mx, my)) {
      isPressed = true;
    }
  }
  
  void mouseReleased(int mx, int my) {
    if(isInside(mx, my)) {
    
    }
    isPressed = false;
  }
  
  boolean isInside(int mx, int my) {
    if(x < mx && x < mx+w && y < my && y < my+h) {
      return true;
    }  
    return false;
  }
}
