void mode1() { 
  pushMatrix();
  background(0);
  //previousWater[(int)random(200)][(int)random(200)] = 255;
  translate(width/2, height/2);
  drawWaterRipple();
  blendMode(BLEND);
  if (phase1CornerCall ==true) {
    targetingCenter=true;
  }

  if (waterTrigger==true) {
    float targetX=map(targetSystem.get(0).x, -width/2-5, width/2+5, 0, 640);
    float targetY=map(targetSystem.get(1).y, -height/2-5, height/2+5, 0, 480);
    previousWater[(int)targetX][(int)targetY] = waterCount;
    waterCount += 3;
    if (waterCount>255)waterCount=255;
    waterTrigger=false;
    targetCount++;
  }
  imageMode(CENTER);
  image(waterRipple, 0, 0, width+10, height+10);
  //spaceImageGraphic.clear();
  for (int s=0; s<targetSystem.size(); s++) {
    targetSystem.get(s).update();
    targetSystem.get(s).showBall();
  }
  rectMode(CENTER);
  stroke(255, 100);
  strokeWeight(0.5);
  noFill();
  for (int s=0; s<spaceImages.size(); s++) {
    spaceImages.get(s).update();
    spaceImages.get(s).showImage();

    if (spaceImages.get(s).imageSizeY<12) {
      spaceImages.remove(s);
    }
  }
  if (spinMoveFaster) {
    spinMoveFaster=false;
  }
  if (photoTrigger==true) {
    int dir = 0;
    if (random(2)>1) {
      dir = 1;
    } else {
      dir = 0;
    }
    /*    
     // 0 blank 1 BWImg 2 colImg 3 spin 
     boolean photoTrigger = false;
     boolean photoTriggerImageBW = false;
     boolean photoTriggerImage = false;
     boolean photoKill = false;
     boolean photoSpin = false;
     */
    if (phase1CornerCall==true) {
      if (photoTriggerImageRect==true) {
        spaceImages.add(new SpaceImages(500+random(-20, 20), 
          targetSystem.get(0).y, 
          dir, targetSystem.get(0).x, 0));
      } else if (photoTriggerImageBW==true) {
        spaceImages.add(new SpaceImages(500+random(-20, 20), 
          targetSystem.get(0).y, 
          dir, targetSystem.get(0).x, 1));
      } else if (photoTriggerImage==true) {
        spaceImages.add(new SpaceImages(500+random(-20, 20), 
          targetSystem.get(0).y, 
          dir, targetSystem.get(0).x, 2));
      }
      showImageCounterAfterSpin ++;
    } else { 
      if (photoTriggerImageRect==true) {
        spaceImages.add(new SpaceImages(500+random(-20, 20), 
          random(-height/2+312, height/2-312), 
          dir, targetSystem.get(0).x, 0));
      } else if (photoTriggerImageBW==true) {
        spaceImages.add(new SpaceImages(500+random(-20, 20), 
          random(-height/2+312, height/2-312), 
          dir, targetSystem.get(0).x, 1));
      } else if (photoTriggerImage==true) {
        spaceImages.add(new SpaceImages(500+random(-20, 20), 
          random(-height/2+312, height/2-312), 
          dir, targetSystem.get(0).x, 2));
      }
    }
    photoTrigger = false;
  } 

  if (photoKill==true) {
    for (int s=0; s<spaceImages.size(); s++) {
      spaceImages.get(s).kill();
    }
    photoKill = false;
  }
  ShowobservationStar();
  // blendMode(ADD);
  imageMode(CENTER);
  image(observateStarBackground, 0, 0, width, height);
  //  if (random(5)>4)
  //   filter(INVERT);

  popMatrix();
  noStroke();
}
