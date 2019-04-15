import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import oscP5.*;
import netP5.*;
import javax.sound.sampled.*;
import themidibus.*; //Import the library
Runtime runtime;
OperatingSystemMXBean operatingSystemMXBean;
OscP5 oscP5;
NetAddress myRemoteLocation;
MidiBus myBus; // The MidiBus
Midi midi;
String CPUperform="";

void setup() {
  size(1200, 1200, P3D);
  hint(DISABLE_DEPTH_TEST);
}
void draw() {
  background(0);
}
void blackHole() {
  translate(width/2, height/2);

  blendMode(ADD);
  pushMatrix();
  for (int s=0; s<50; s++) {
    rotateX(radians(s+float(frameCount)/21.3));
    rotateY(radians(s+float(frameCount)/16.8));
    fill(255, abs(-s*4), 0, 20); 
    ellipse(0, 0, 100+s*4.5, 100+s*4.5);
  }
  popMatrix();


  blendMode(BLEND);
  noStroke();
  for (int s=0; s<40; s++) {
    fill(0, 40);
    ellipse(0, 0, s*4, s*4);
  }
}
