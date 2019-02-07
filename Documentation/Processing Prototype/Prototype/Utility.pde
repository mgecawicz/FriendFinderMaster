abstract class UI_Component {
  private String id;                                         // Recognizble phrase for the component - i.e. Button0 for easy reference
  private float x, y, w, h;                                  // Location and dimension
  private float originalX, originalY, originalW, originalH;  // Original location and dimension
  private boolean isFixedPosition = false;                   // Locked position

  UI_Component(String id, int x, int y, int w, int h) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.originalX = x;
    this.originalY = y;
    this.originalW = w;
    this.originalH = h;
  }

  abstract void run();  // All subclasses ust define this method

  // Accessors
  String getID() {
    return id;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getW() {
    return w;
  }

  float getH() {
    return h;
  }

  float getOriginalX() {
    return originalX;
  }

  float getOriginalY() {
    return originalY;
  }

  float getOriginalW() {
    return originalW;
  }

  float getOriginalH() {
    return originalH;
  }


  // Mutators
  void setY(float y) {
    if (!isFixedPosition) {
      this.y = y;
    }
  }

  void setX(float x) {
    if (!isFixedPosition) {
      this.x = x;
    }
  }

  void setW(float w) {
    this.w = w;
  }
  
  void setH(float h) {
    this.h = h;
  }

  void setFixedPosition(boolean b) {
    this.isFixedPosition = b;
  }
}



public class UIRect extends UI_Component {
  private color fillColor;

  public UIRect(String id, int x, int y, int w, int h) {
    super(id, x, y, w, h);
    this.fillColor = color(0);
  }

  public UIRect(String id, int x, int y, int w, int h, color fillColor) {
    super(id, x, y, w, h);
    this.fillColor = fillColor;
  }

  public void run() {
    pushStyle();
    rectMode(CORNER);
    noStroke();
    fill(fillColor);
    rect(super.getX(), super.getY(), super.getW(), super.getH());
    popStyle();
  }
}



public class TextBox extends UI_Component {
  private String content;
  private int textSize;
  private color fillColor, textColor;

  private String aligned;

  public TextBox(String id, String content, int x, int y, int w, int h) {
    super(id, x, y, w, h);
    this.content = content;
    this.textSize = 15;
    this.fillColor = color(0);
    this.textColor = color(255);

    aligned = "LEFT";
  }

  public TextBox(String id, String content, int x, int y, int w, int h, color fillColor, color textColor) {
    super(id, x, y, w, h);
    this.content = content;
    this.textSize = 15;
    this.fillColor = fillColor;
    this.textColor = textColor;

    aligned = "LEFT";
  }

  public void run() {
    pushStyle();
    rectMode(CORNER);

    noStroke();
    fill(fillColor);
    rect(super.getX(), super.getY(), super.getW(), super.getH());

    if ("LEFT".equals(aligned)) {
      textAlign(LEFT, CENTER);
    } else if ("RIGHT".equals(aligned)) {
      textAlign(RIGHT, CENTER);
    } else {
      textAlign(CENTER, CENTER);
    }

    textSize(textSize);

    fill(textColor);
    text(" "+content, super.getX(), super.getY(), super.getW(), super.getH());
    popStyle();
  }

  public void align(String aligned) {
    this.aligned = aligned;
  }

  public void setTextSize(int textSize) {
    this.textSize = textSize;
  }
}



public class RoundedTextBox extends TextBox {
  public RoundedTextBox(String id, String content, int x, int y, int w, int h) {
    super(id, content, x, y, w, h);
  }

  public RoundedTextBox(String id, String content, int x, int y, int w, int h, color fillColor, color textColor) {
    super(id, content, x, y, w, h, fillColor, textColor);
  }

  void run() {
    pushStyle();
    rectMode(CORNER);

    noStroke();
    fill(super.fillColor);
    rect(super.getX(), super.getY(), super.getW(), super.getH(), 5);

    if ("LEFT".equals(super.aligned)) {
      textAlign(LEFT, CENTER);
    } else if ("RIGHT".equals(super.aligned)) {
      textAlign(RIGHT, CENTER);
    } else {
      textAlign(CENTER, CENTER);
    }

    textSize(super.textSize);

    fill(super.textColor);
    text(" "+super.content, super.getX(), super.getY(), super.getW(), super.getH());
    popStyle();
  }
}



public class Button extends UI_Component {
  color fillColor, textColor;
  color activeFillColor, activeTextColor;
  color borderColor = -1;
  int textSize = 15;

  public Button(String id, int x, int y, int w, int h) {
    super(id, x, y, w, h);
    this.fillColor = color(0);
    this.textColor = color(255);
    this.activeFillColor = color(255);
    this.activeTextColor = color(0);
  }

  public Button(String id, int x, int y, int w, int h, color fillColor, color textColor, color activeFillColor, color activeTextColor) {
    super(id, x, y, w, h);
    this.fillColor = fillColor;
    this.textColor = textColor;
    this.activeFillColor = activeFillColor;
    this.activeTextColor = activeTextColor;
  }

  public void run() {
    pushStyle();
    rectMode(CORNER);

    if (mousePressed && mouseX > super.getX() && mouseX < super.getX()+super.getW() && mouseY > super.getY() && mouseY < super.getY()+super.getH() && wait == 0) {
      fill(activeFillColor);
    } else {
      fill(fillColor);
    }

    stroke(borderColor);
    strokeWeight(2);
    rect(super.getX(), super.getY(), super.getW(), super.getH(), 5);

    textAlign(CENTER, CENTER);

    if (mousePressed && mouseX > super.getX() && mouseX < super.getX()+super.getW() && mouseY > super.getY() && mouseY < super.getY()+super.getH() && wait == 0) {
      fill(activeTextColor);
    } else {
      fill(textColor);
    }
    textSize(textSize);
    text(super.getID(), super.getX(), super.getY(), super.getW(), super.getH());
    popStyle();
  }

  public void setBorderColor(color borderColor) {
    this.borderColor = borderColor;
  }

  public void setTextSize(color textSize) {
    this.textSize = textSize;
  }

  public boolean isPressed() {
    if (mouseX > super.getX() && mouseX < super.getX()+super.getW() && mouseY > super.getY() && mouseY < super.getY()+super.getH()) {
      return true;
    }

    return false;
  }
}