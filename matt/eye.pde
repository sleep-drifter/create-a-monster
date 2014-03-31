class Eye {

  int savedTime;
  int totalTime; // frequency of blinking
  float lidY;
  boolean direction = true;
  color c = #F5CFA6; 
  boolean blinkTime = true;
  float xpos;
  float ypos;
  float eyeSize;
  int irisC;

  Eye(color _c, color _irisC, float _xpos, float _ypos, int _totalTime, float _eyeSize) {
    c = _c;
    irisC = _irisC;
    xpos = _xpos;
    ypos = _ypos;
    totalTime = _totalTime;
    eyeSize = _eyeSize;
    savedTime = millis();
    lidY =  eyeSize*2.2;
    
  }

  void display() {
    noStroke();
    pushMatrix();
    
//    background(c-10);
    

    //:eye white
    fill(100);

    ellipse(-30, -15, eyeSize*2.1, eyeSize);

    //:iris
    float x =  map (mouseX, 0, width, -eyeSize*.33, eyeSize*.33);
    float eyeColor =  map (mouseX, 0
      , width, 40, 60);
    fill(irisC, 80, eyeColor);
    strokeWeight(6);
    ellipseMode(CENTER);
    ellipse(x, 0, eyeSize*.9, eyeSize*.9);
    fill(55, 50, eyeColor);


    //:pupil
    float m = map (mouseX, 0, width, -eyeSize*.43, eyeSize*.43);
    float n = map (mouseY, 0, height, -eyeSize*.15, eyeSize*.15);
    fill(0);
    stroke(0);
    ellipseMode(CENTER);

    ellipse(m, n, eyeSize*.3, eyeSize*.3);
    fill(100, 80);
    noStroke();
    
    //timing function
    int passedTime = millis() - savedTime;
    if(passedTime > totalTime){
    blinkTime = true;
    savedTime = millis();
    }
    if (blinkTime) {
      blink();
    } 
        popMatrix();
  }

  void blink() {
    pushMatrix();
//    translate(xpos, ypos);
    
    // Start blink sequence
    if (direction) {
      lidY -=4;
      if (lidY < eyeSize/3.5) { //target t=20
        direction = false;  //Change direction
      }
    } 
    else {
      lidY +=4;

      if (lidY > eyeSize*2) {
        direction = true;  //Change direction
        blinkTime = false; // only blink ONCE
        lidY+=0;
      }
    }

    noFill();
    stroke(c-10);
    strokeWeight(eyeSize/1.5);
    //lower lid
    beginShape();
    vertex(-eyeSize*2.3, 0);
    bezierVertex(-eyeSize, 20, 0, lidY, eyeSize*1.8, 0);
    endShape();

    //upper lid
    beginShape();
    vertex(-eyeSize*2.3, -0);
    stroke(c);
    bezierVertex(-eyeSize, -20, 0, -lidY, eyeSize*1.8, -0);
    endShape();
    noStroke();
popMatrix();
  }
  
}

