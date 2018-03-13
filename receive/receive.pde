
import oscP5.*;
import netP5.*;

OscP5 osc;

ArrayList<Thing> things = new ArrayList<Thing>();
PFont font;

void setup() {
  smooth();
  size(800, 800);
  textSize(40);
  osc = new OscP5(this, 1818);
  font = loadFont("Inconsolata-48.vlw");
  textFont(font,48);
}

void draw() {
  background(0);

  for (int i = things.size() - 1; i >= 0; i--) {
    Thing thing = things.get(i);
      if (thing.alive()) {
        thing.draw();
      }
      else {
        things.remove(i);
      }
  }
}

void oscEvent(OscMessage m) {
  int i;
  String sample = null;
  float pan = 0.5;
  float gain = 1;

  for(i = 0; i < m.typetag().length(); ++i) {
    String name = m.get(i).stringValue();
    switch(name) {
      case "s":
        sample = m.get(i+1).stringValue();
        break;
      case "pan":
        pan = m.get(i+1).floatValue();
        break;
      case "gain":
        gain = m.get(i+1).floatValue();
        break;
      case "scene":
        String scene = m.get(i+1).stringValue();
        println("scene: " + scene);
        break;
    }
    ++i;
  }
  
  if (sample != null) {
    things.add(new Thing(sample, pan, gain));
  }
}

class Thing {
  int start;
  int life;
  String txt;
  float pan;
  float gain;
  
  Thing(String txt, float pan, float gain) {
    start = millis();
    life = 550;
    this.txt = txt;
    this.pan = pan;
    this.gain = gain;
  }
  
  boolean alive () {
    // print("start: " + start + " life " + life + " now " + millis() + "\n");
    return((start+life) >= millis());
  }
  
  void draw () {
    float age = millis() - start;
    float progress = age/life;
    if (progress < 1) {
      fill(255,255,255,int((1.0-progress)*255.0));
      textAlign(CENTER);
      //text(txt,width*pan,height/2);
      ellipse(width*pan,height/2, 100*gain,100*gain);
    }
  }
}