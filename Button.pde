import java.lang.reflect.Method;

class Button {
  String name;
  int x, y, w, h;
  color background, pressed, stroke;
  boolean isPressed;
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
    stroke     = color(100);
    
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
    
    textAlign(CENTER, CENTER);
    textSize(28);
    fill(255);
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
    isPressed = false;
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
  }
  
  boolean isInside(int mx, int my) {
    if(x < mx && mx < x+w && y < my && my < y+h) {
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

class ToggleButton extends Button {
  boolean value;
  
  ToggleButton(PApplet app, String _name, boolean value, int _x, int _y, int _w, int _h) {
    super(app, _name, _x, _y, _w, _h);
    value = true;
  }
  
  void draw() {
    pushMatrix();
    pushStyle();
    
    if(isPressed) {
      fill(pressed);
    } else {
      fill(background);
    }
    
    if(value) {
      stroke(stroke + color(120));
    } else {
      stroke(stroke);
    }
    rect(x, y, w, h);
    
    textAlign(CENTER, CENTER);
    textSize(28);
    fill(255);
    text(name, x+w/2, y+h/2);
    
    popStyle();
    popMatrix();
  };
  
  void mousePressed(int mx, int my) {
    super.mousePressed(mx, my);
    if(isInside(mx, my)) {
      value = !value;
      println(value);
    }
  }
}
