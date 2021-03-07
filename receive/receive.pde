
import java.util.Iterator;

import oscP5.*;
import netP5.*;


OscP5 osc;

ArrayList<Orbit> orbits = new ArrayList<Orbit>();
PFont font;
float cps = 0;
float showCycles = 2;
int orbitn = 7;
float lastCycle = 0;
float lastTime = 0;
int orbitHeight = 16;
int h = orbitHeight - 4;

void setup() {
  frameRate(30);
  surface.setTitle("lines");
  smooth();
  size(1024, 180);
  textSize(40);
  osc = new OscP5(this, 2020);
  font = loadFont("Inconsolata-48.vlw");
  textFont(font,48);
  synchronized(orbits) {
    for (int i = 0; i < orbitn; ++i) {
      orbits.add(new Orbit());
    }
  }
}

void draw() {
  background(0,255,0);
  float now = millis();
  float elapsed = now - lastTime;
  float cycle = ((elapsed * cps)/1000) + lastCycle;
  synchronized(orbits) {
    pushMatrix();
    for (int i = 1; i < orbitn; ++i) {
      Orbit o = orbits.get(i);
      translate(0,orbitHeight);
      o.draw(cycle);
    }
    popMatrix();
  }
}

void oscEvent(OscMessage m) {
  float t = millis();
  int i;
  int orbit = -1;
  float cycle = -1;
  

  for(i = 0; i < m.typetag().length(); ++i) {
    String name = m.get(i).stringValue();
    switch(name) {
      case "orbit":
        orbit = m.get(i+1).intValue();
        break;
      case "cycle":
        cycle = m.get(i+1).floatValue();
        break;
      case "cps":
        cps = m.get(i+1).floatValue();
        break;
    }
    ++i;
  }
  if (orbit >= 0 && cycle >= 0) {
    synchronized(orbits) {
      Event event = new Event(cycle, t);
      Orbit o = orbits.get(orbit % orbitn);
      lastCycle = cycle;
      lastTime = t;
      o.add(event);
    }
  }
}

class Orbit {
  Boolean state = false;
  ArrayList<Event> events = new ArrayList<Event>();
  
  void add (Event event) {
    events.add(0,event);
    state = !state;
  }
  
  void draw(float cycle) {
    Boolean state = this.state;
    noFill();
    beginShape();
    strokeWeight(3);
    stroke(255,255,255);
    vertex(width, state ? 0 : h);
    Iterator<Event> i = events.iterator();
    while (i.hasNext()) {
      Event event = i.next();
      float pos = (event.cycle-(cycle-showCycles))/showCycles;
      if (pos < 0) {
        i.remove();
      }
      else {
        vertex(width * pos, state ? 0 : h);
        vertex(width * pos, state ? h : 0);
        state = !state;
      }
    }  
    vertex(0, state ? 0 : h);
    endShape();
  }
}

class Event {
  float cycle;
  float start;
  
  Event(float cycle, float start) {
    this.cycle = cycle;
    this.start = start;
  }
}
