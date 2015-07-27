import java.lang.reflect.Method;

class Button {
  String name;
  int x, y, w, h;
  color background, pressed, stroke;
  boolean isPressed;
  PFont font;
  PApplet _parent;
  private Method onEventMethod;
  
  Button(PApplet app, String _name, int _x, int _y, int _w, int _h) {
    _parent = app;
    name = _name;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    background = color(30);
    pressed    = color(100);
    stroke     = color(255);
    
    font = loadFont("font.vlw");
    
    onEventMethod = getMethodRef(_parent, "onButtonEvent", new Class[] {
      String.class, // name
      int.class,    // mouseX
      int.class,    // mouseY
      boolean.class // pressed?
    });
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
      try {
        onEventMethod.invoke( _parent, new Object[] { 
          (String)name,
          (int)mx,
          (int)my,
          (boolean)isPressed
        } 
        );
      } 
      catch (Exception e) {
      }
    }
  }
  
  void mouseReleased(int mx, int my) {
    if(isInside(mx, my)) {
      try {
        onEventMethod.invoke( _parent, new Object[] { 
          (String)name,
          (int)mx,
          (int)my,
          (boolean)isPressed
        } 
        );
      } 
      catch (Exception e) {
      }
    }
    isPressed = false;
  }
  
  boolean isInside(int mx, int my) {
    if(x < mx && x < mx+w && y < my && y < my+h) {
      return true;
    }  
    return false;
  }
  
  // code from https://github.com/kougaku/OculusRiftP5/blob/master/OculusRift_BasicExample/OculusRift.pde#L210-L218
  private Method getMethodRef(Object obj, String methodName, Class[] paraList) {
    Method ret = null;
    try {
      ret = obj.getClass().getMethod(methodName, paraList);
    }
    catch (Exception e) {
    }
    return ret;
  }

}
