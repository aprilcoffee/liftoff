void initPhase() {

  print.beginDraw();
  print.background(0);
  print.camera(width/2.0 + camShakeX, 
    height/2.0 + camShakeY, 
    (height/2.0) / tan(PI*30.0 / 180.0)+camShakeZ, 
    width/2.0, height/2.0, 0, 
    0, 1, 0);
  print.imageMode(CENTER);
  print.colorMode(RGB, 255);
  print.blendMode(BLEND);
  print.pushMatrix();

  float shakeGlitch = map(transition0to1Dark, 0, 255, 5, 150);
  LTGlogo = loadImage("LTG.png");
  LTGlogo.loadPixels();
  color randomColor = color(random(255), random(255), random(255), 255);
  if (random(100)<(25+shakeGlitch/2)) {
    for (int y=0; y<LTGlogo.height; y++) {
      for (int x=0; x<LTGlogo.width; x++) {
        // get the color for the pixel at coordinates x/y
        color pixelColor = LTGlogo.pixels[y + x * LTGlogo.height];
        if (pixelColor == color(255)) {
          // percentage to mix
          float mixPercentage = .5 + random(50)/50;
          // mix colors by random percentage of new random color
          LTGlogo.pixels[y + x * LTGlogo.height] =  lerpColor(pixelColor, randomColor, mixPercentage);
        }
        if (random(100)<25) {
          randomColor = color(random(255), random(255), random(255), 255);
        }
      }
    }
  }
  LTGlogo.updatePixels();
  for (int s=0; s<100; s++) {
    int x1 = 0;
    int y1 = floor(random(LTGlogo.height));

    int x2 = round(x1 + random(-shakeGlitch, shakeGlitch));
    int y2 = round(y1 + random(-shakeGlitch/3, shakeGlitch/3));

    int w = LTGlogo.width;
    int h = floor(random(10));
    LTGlogo.set(x2, y2, LTGlogo.get(x1, y1, w, h));
  }
  print.translate(width/2, height/2);
  for (int s=0; s<blobs.size(); s++) {
    blobs.get(s).update();
    blobs.get(s).showMode1(print);
    blobs.get(s).cons();
  }
  blackHole(print);
  print.image(LTGlogo, -10, 0, width*0.4, height*0.4);

  print.popMatrix();
  print.blendMode(BLEND);


  print.endDraw();
  for (int scr_num =0; scr_num<4; scr_num++) {
    image(print, scr_num * newHeight, 0, newHeight, newHeight);
  }
}
class Blob {
  PVector pos;
  PVector vel = new PVector(0, 0);
  float radius;
  float yoff = random(100);
  boolean killMode1 = false;
  int killMode1Num = 255;

  // float xoff = random(100);
  Blob(float ex, float ey, float er) {
    pos = new PVector(ex, ey);
    radius = er;
  }
  void update() {
    PVector newVel = new PVector(0, 0);
    newVel.div(50);
    newVel.limit(3);
    vel.lerp(newVel, 0.2);
    pos.add(vel);
  }

  void cons() {
    pos.x = constrain(pos.x, -width/4, width/4);
    pos.y = constrain(pos.y, -height/4, height/4);
  }
  void showMode1(PGraphics P) {
    if (killMode1==true) {
      killMode1Num-=10;
      if (killMode1Num<0)killMode1Num=0;
    }
    //fill(255);
    P.noFill();
    P.stroke(killMode1Num);
    P.strokeWeight(2);
    pushMatrix();
    P.translate(pos.x, pos.y);
    P.beginShape();
    float xoff = 0;
    for (float i =0; i<=TWO_PI; i+=0.1) {

      float offset = map(noise(xoff, yoff), 0, 1, -60, 60);
      float r = radius+offset;
      float x = r*cos(i);
      float y = r*sin(i);

      P.vertex(x, y);
      xoff+=0.1;
    }
    //stroke(255, 0, 0);
    P.endShape(CLOSE);
    popMatrix();
    yoff+=0.01;
  }
  void show() {

    //fill(255);
    noFill();
    stroke(255, 100);
    strokeWeight(2);
    pushMatrix();
    translate(pos.x, pos.y);
    beginShape();
    float xoff = 0;
    for (float i =0; i<=TWO_PI; i+=0.1) {

      float offset = map(noise(xoff, yoff), 0, 1, -30, 30);
      float r = radius+offset;
      float x = r*cos(i);
      float y = r*sin(i);

      vertex(x, y);
      xoff+=0.1;
    }
    //stroke(255, 0, 0);
    endShape(CLOSE);
    popMatrix();
    yoff+=0.01;
  }
  void showWithFill() {
    //fill(255);
    noFill();
    stroke(255, 150);
    strokeWeight(2);
    fill(0, 100);
    pushMatrix();
    translate(pos.x, pos.y);
    beginShape();
    float xoff = 0;
    for (float i =0; i<=TWO_PI; i+=0.1) {

      float offset = map(noise(xoff, yoff), 0, 1, -30, 30);
      float r = radius+offset;
      float x = r*cos(i);
      float y = r*sin(i);

      vertex(x, y);
      xoff+=0.1;
    }
    //stroke(255, 0, 0);
    endShape(CLOSE);
    popMatrix();
    yoff+=0.01;
  }
}

void blackHole(PGraphics P) {
  P.pushMatrix();
  //P.translate(P.width/2, P.height/2);

  P.blendMode(ADD);
  P.hint(DISABLE_DEPTH_TEST);
  P.pushMatrix();
  P.noStroke();
  P.blendMode(ADD);
  for (int s=0; s<50; s++) {
    P.rotateX(radians(s+float(frameCount)/21.3));
    P.rotateY(radians(s+float(frameCount)/16.8));
    P.fill(255, abs(-s*4), 0, 20); 
    P.ellipse(0, 0, 800+s*5, 800+s*5);
  }
  P.popMatrix();


  P.blendMode(BLEND);
  P.noStroke();
  for (int s=0; s<180; s++) {
    P.fill(0, 40);
    P.ellipse(0, 0, s*4, s*4);
  }

  P.blendMode(ADD);
  P.popMatrix();
}
