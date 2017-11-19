
import oscP5.*;
import netP5.*;

OscP5 osc;

void setup() {
  size(800, 800);
  textSize(40);
  osc = new OscP5(this, 1818);
}

void draw() {
  background(0);
}

void oscEvent(OscMessage m) {
  int i;
  for(i = 0; i < m.typetag().length(); ++i) {
    String name = m.get(i).stringValue();
    switch(name) {
      case "s":
        String sample = m.get(i+1).stringValue();
        println("sample: " + sample);
        break;
      case "scene":
        String scene = m.get(i+1).stringValue();
        println("scene: " + scene);
        break;
    }
    i++;
  }
}