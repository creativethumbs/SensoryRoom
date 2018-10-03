// code repurposed from Jon Loeb's bubblemaking visualization 
// to include audio feedback and Arduino input
// --Ticha Sethapakdi

import processing.serial.*;
import cc.arduino.*;
import processing.sound.*;

SoundFile voice1;
SoundFile voice2;
SoundFile voice3;
SoundFile voice4;

Arduino arduino;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

int roomWidth = 30;
int roomLength = 100;

int lightActualLength = 4;
PImage room;

float xl=0;
float xr=1200;
float speed=5;

int keyCount=0;

ParticleSystem ps;
ParticleSystem ps2;
ParticleSystem ps3;
ParticleSystem ps4;


boolean pin2triggered = false;
boolean pin3triggered = false;
boolean pin4triggered = false;
boolean pin5triggered = false; 

// Color of the brush to increment through hue.
int col;

boolean sending;
boolean bDrawLights;



void setup() { 
  println(Arduino.list());
  
  voice1 = new SoundFile(this, "voice1mono.wav");
  voice1.loop(); 
  voice1.amp(0); 
  voice2 = new SoundFile(this, "voice2mono.wav");
  voice2.loop(); 
  voice2.amp(0); 
  voice3 = new SoundFile(this, "voice3mono.wav");
  voice3.loop(); 
  voice3.amp(0); 
  voice4 = new SoundFile(this, "voice4mono.wav");
  voice4.loop(); 
  voice4.amp(0); 

  arduino = new Arduino(this, Arduino.list()[3], 57600);

  for (int i = 2; i <= 5; i++) {
    arduino.pinMode(i, Arduino.INPUT);
  }
 
  size(800, 600);
  frameRate(30);
  background(0); 

  ps = new ParticleSystem(new PVector(width*0.25, height*0.35), new PVector (0, 0.0015), 226,165,104);
  ps2 = new ParticleSystem(new PVector(width*0.65, height*0.35), new PVector (0, 0.0015), 148,186,183);
  ps3 = new ParticleSystem(new PVector(width*0.25, height*0.75), new PVector (0, 0.0015), 164,196,159);
  ps4 = new ParticleSystem(new PVector(width*0.65, height*0.75), new PVector (0, 0.0015), 224,212,145);
   
}


void draw() {
  background(0); 

  if (arduino.digitalRead(2) == Arduino.HIGH) {
    ps.addParticle();
    if (!pin2triggered) {
      pin2triggered = true; 
      voice1.amp(1);
    }
  } else if (pin2triggered) {
    pin2triggered = false;
    voice1.amp(0);
  }

  if (arduino.digitalRead(3) == Arduino.HIGH) {
    ps2.addParticle();
    if (!pin3triggered) {
      pin3triggered = true; 
      voice2.amp(1);
    }
  } else if (pin3triggered) {
    pin3triggered = false;
    voice2.amp(0);
  }

  if (arduino.digitalRead(4) == Arduino.HIGH) {
    ps3.addParticle();
    if (!pin4triggered) {
      pin4triggered = true; 
      voice3.amp(1);
    }
  } else if (pin4triggered) {
    pin4triggered = false; 
    voice3.amp(0);
  }

  if (arduino.digitalRead(5) == Arduino.HIGH) {
    ps4.addParticle();
    if (!pin5triggered) {
      pin5triggered = true; 
      voice4.amp(1);
    }
  } else if (pin5triggered) {
    pin5triggered = false; 
    voice4.amp(0);
  }


  ps.run();
  ps2.run();
  ps3.run();
  ps4.run();
}
