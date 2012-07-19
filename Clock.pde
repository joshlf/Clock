PFont LCGrande, LCGrandeBold;
int seconds = 0, secondcount = 0, minutes = 0, hours = 12, hourfrac = 0, hourdisplay;
boolean am = true, ambool = true;
String clocktime;


void setup() {
  size(400,500);
  background(255);
  smooth();
  frameRate(1);
  LCGrandeBold = loadFont("LucidaGrande-Bold-48.vlw");
  LCGrande = loadFont("LucidaGrande-48.vlw");
  textFont(LCGrande, 50);
  
  //Initialize Clock
  setclock(1);
  
}

void draw() {
  //Calculations
  seconds++;
  secondcount++;
  if (seconds == 60) {
    seconds = 0;
    minutes++;
  }
  if (secondcount == 720) {
    secondcount = 0;
    hourfrac++;
  }
  if (hourfrac == 60) {
    hourfrac = 0;
  }
  if (minutes == 60) {
    minutes = 0;
    hours++;
  }
  if ((hours == 12)&&(ambool)) {
    am = !am;
    ambool = false;
  }
  if (hours == 13) {
    hours = 1;
    ambool = true;
  }
  
  //Draw
  
  textFont(LCGrande,50);
  translate(200,200);
  background(255);
  fill(255);
  strokeWeight(7);
  stroke(0);
  ellipse(0,0,300,300);
  strokeWeight(2);
  
  rotate(seconds*(PI/30));
  strokeWeight(4);
  line(0,0,0,-125);
  strokeWeight(7);
  rotate(-seconds*(PI/30));
  
  rotate(minutes*(PI/30));
  line(0,0,0,-125);
  rotate(-minutes*(PI/30));
  
  rotate(hourfrac*(PI/30));
  line(0,0,0,-100);
  rotate(-hourfrac*(PI/30));
  
  //Digital Clock
  if (hours == 0) {
    hourdisplay = 12;
  } else {
    hourdisplay = hours;
  }
  clocktime = "" + nf(hourdisplay, 2) + ":" + nf(minutes, 2) + ":" + nf(seconds, 2);
  fill(0);
  textSize(50);
  text(clocktime,-112,225);

  //AM/PM
  if (am) {
    textFont(LCGrandeBold,16);
    stroke(0);
    fill(0);
    rect(-139,192,24,10);
    textSize(16);
    text("PM",-139,221);
    fill(255);
    text("AM",-139,203);
  } else {
    textFont(LCGrandeBold,16);
    stroke(0);
    fill(0);
    rect(-139,210,24,10);
    textSize(16);
    text("AM",-139,203);
    fill(255);
    text("PM",-139,221);
  }
  
  
  if ((minutes == 1)&&(seconds == 1)) {
    setclock(1);
  }
} 

void setclock(int offset) {
    if (hour() > 12) {
    am = false;
    hours = hour() - 12;
  } else {
    am = true;
    hours = hour();
  }
  minutes = minute();
  seconds = second() + offset;
  secondcount = (minutes % 5)*60 - seconds;
  hourfrac = hours*5 + int(minutes/12);
}
