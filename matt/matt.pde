//Eye Class
Eye eyes = new Eye(

#E09696, // body color
30, //iris color
10, //xpos
200, //ypos
4000, //blink time
30//size
);
int savedTime;
int totalTime = 5000;

boolean stage1;
boolean stage2;
boolean stage3;
boolean stage4;
boolean stage5;

//Mouth___________________________________________
float yBez;
float xBez;
float horizontalBez;
float verticalBez;
float originx1;
float originy1;
float originx2;
float originy2;
float xpos;

//___________________________________________
float distanceFromBait;
int r =8;
//control sin/cos waves
float theta = 0.0;
float theta2 = 0.0;

//perlin noise
float time = 0.0;
float increment = 0.01;

float x;
float y;
float xC;
float yC;
float easing;
float theta3;
float thetaC;
PFont f;
boolean living = true;


void setup() {

  size(1500, 900);
  colorMode(HSB, 100);
  background(50);
  f = createFont("Georgia", 16);
  textFont(f);
  savedTime = millis();
}

void draw() {
  //used for chewing
  
  //used for text timer
  int timed = millis();
  background(50);

  //text
  if (timed<10000) {
    drawType(10);
  }

  //new life
  if (keyPressed) {
    if (key == 'R' || key == 'r') {
      newLife();
      living=true;
    }
  } 
  pushMatrix();
  drawEvilMonster();
  showeyes();
  eyebrow();
  mouth();
  popMatrix();
  //living?
  println(timed);
  if ( distanceFromBait < 10 && timed>5000) {
    living = false;
  }
  if (living) {
    cursorBait();
  }
  
}



void cursorBait() {
  pushMatrix();
  if (living) {
    float radius2=50;
    float xWave2 = theta3;



    float targetX2 = mouseX;
    float easing2 = 0.5;
    float dx2 = targetX2 - xC;
    if (abs(dx2) > 1) {
      xC += dx2 * easing2;
    }

    float targetY2 = mouseY;
    float dy2 = targetY2 - yC;
    if (abs(dy2) > 1) {
      yC += dy2 * easing2;
    }
    noStroke();
    fill(20);

    //start panting
    if (stage2) {
      radius2=(sin(xWave2)*1.5) +50;
      ellipse(xC, yC, radius2, radius2);
      theta3 += 0.3;
    }
    if (stage3||stage4) {
      radius2=(sin(xWave2)*5) +50;
      theta3 += 0.5;
      ellipse(xC, yC, radius2, radius2);
    }
    else {
      theta3 += 0.1;
      radius2=(sin(xWave2)*1.1) +50;
      ellipse(xC, yC, radius2, radius2);
    }


    translate(xC, yC);
    fill(#1D7C91);
    float eyeY= map(mouseY, 0, height, 10, -10);
    float eyeX=map(mouseX, 0, width, 10, -10);
    ellipse(eyeX-5, eyeY, 5, 5);
    ellipse(eyeX+5, eyeY, 5, 5);



    if (stage2||stage3) {
      fill(100);
      ellipse(eyeX, eyeY+10, 10, 5);
    }
    if (stage4) {
      fill(100);
      float randommm = random(10, 20);
      ellipse(eyeX, eyeY+10, randommm, randommm);
    }
    popMatrix();
  }
}



float drawEvilMonster() {
  //DISTANCE FROM BAIT++++++++==============================
  distanceFromBait = dist(mouseX, mouseY, x, y+20);

  if (distanceFromBait>600) {
    easing=0.001;
    stage1=true;
    stage2=false;
    stage3=false;
    stage5=false;
    stage4=false;
  }
  if (distanceFromBait>350 && distanceFromBait<600 && living ) {
    easing=0.005;
    stage2=true;
    stage1=false;
    stage3=false;
    stage5=false;
    stage4=false;
  }

  if (distanceFromBait>150 && distanceFromBait<350 && living ) {
    easing=0.01;
    stage3=true;
    stage1=false;
    stage2=false;
    stage5=false;
    stage4=false;
  }

  if (distanceFromBait>10 && distanceFromBait<150 && living) {

    easing=0.1;
    stage5=false;
    stage4=true;
    stage3=false;
    stage1=false;
    stage2=false;
  }

  if (distanceFromBait<10 && living) {
    easing=0.07;
    stage5=true;
    stage4=false;
    stage3=false;
    stage1=false;
    stage2=false;
  }

if (living){
  //easing equation
  float targetX = mouseX;
  float dx = targetX - x;
  if (abs(dx) > 1) {
    x += dx * easing;
  }

  float targetY = mouseY-20;
  float dy = targetY - y;
  if (abs(dy) > 1) {
    y += dy * easing;
  }
}else{
  float targetY=width/2;
  float targetX=width/2;
}

  //controls the sin wave at the bottom
  float xWave = theta;
  theta += 0.22;
  //controls the width flux
  float fluxAmount =3;

  //speed of flux
  float x2 = theta2;
  theta2 += 0.05;
  if (stage2) {
    theta2+=0.1;
    fluxAmount=5;
    theta += 0.32;
  }
  if (stage3) {
    fluxAmount=8;
    theta2+=0.2;
    theta += 0.42;
  }





  //variation in size
  float w = (cos(x2)*fluxAmount)+160;
  float h = (sin(x2)*fluxAmount)+80;

  //color filling
  float filling = map((cos(x2)*fluxAmount), -fluxAmount, fluxAmount, 70, 100);
  fill(#E09696);

  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  translate(x, y);
  rect(0, 0, w, h);
  ellipse(0, -h/2, w, w-(w/2));
  stroke(0);

  // WAVE FORM BELOW
  for (int i = 0; i <= w-r; i++) {

    ellipseMode(CORNER);
    //sin function
    float y = sin(xWave)*3.5;
    noStroke();
    rectMode(CORNER);
    rect(i-(w/2), y+((h-8)/2), r, r, 0, 0, 5, 5);
    stroke(0);
    //    point(i-(w/2), y-100);
    // Move along x-axis
    xWave += 0.4;
  }

  //++++++++==============================
  return distanceFromBait;
}
void showeyes () {
  pushMatrix();
  translate(0, -20);
  eyes.display();
  popMatrix();
}


void eyebrow() {
  stroke(#C68383);
  strokeWeight(16);
  noFill();


  if (stage1 && living) {
    yBez=-20;
  }
  if (stage2 && living) {
    yBez=-10;
  }

  if (stage3||stage4||stage5) {
    yBez=0;//brow DOWN
  }
  bezier(-30, -40, xBez, yBez-30, xBez, yBez-30, 30, -40);
}
void chewing() {
      
      float xWave = thetaC;
      thetaC += 0.2;
      xpos=(sin(xWave)*5) +20;

      strokeWeight(6);
      pushMatrix();
      translate(0, 20);
      line(-xpos, 0, xpos, 0);
      bezier(-xpos-20, 10, -xpos-10, 0, -xpos-10, 0, -xpos-20, -10);
      bezier(xpos+20, 10, xpos+10, 0, xpos+10, 0, xpos+20, -10);
      popMatrix();
    }
  void mouth() {
    stroke(#C68383);
    strokeWeight(6);
    if (stage1 && living == true) {
      yBez=0;
      bezier(-30, 20, xBez, yBez+20, xBez, yBez+20, 30, 20);
    }
    if (stage2 && living == true) {
      yBez=5;
      bezier(-30, 20, xBez, yBez+20, xBez, yBez+20, 30, 20);
    }

    if (stage3 && living == true) {
      fill(100);
      yBez=15;
      line(-30, 20, 30, 20);
      bezier(-30, 20, xBez, yBez+20, xBez, yBez+20, 30, 20);
    }


    if (stage4 && living == true ) {
      fill(100);
      yBez=15;
      line(-30, 20, 30, 20);
      bezier(-30, 20, xBez, yBez+20, xBez, yBez+20, 30, 20);
    }

    if (stage5 || living==false) {
      chewing();
    }
  }

  void drawType(float x) {

    text("Run away from Mr. Blob!", x, height-22);
    text("Press 'R' for a new life!", x, height-5);
  }


  void newLife() {


    x=-50;
    y=-50;
  }

