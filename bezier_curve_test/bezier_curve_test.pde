int scl = 40;
int cols, rows;
int n = 5;
PVector controlPoint2 = new PVector(160, 200);

void drawGraph(){
  push();
  strokeWeight(1);
  textSize(15);
  fill(0);
  for (int y = 0; y < rows; y++){
    line(0, y*scl, width, y*scl);
    text(y*scl, 0, y*scl + 15);
  }
    for (int x = 0; x < cols; x++){
      line(x*scl, 0, x*scl, height);
      text(x*scl, x*scl, 15);
  }
  pop();
}


void setup() {
  size(1015, 983);
  cols = floor(width/scl);
  rows = floor(height/scl);
  drawGraph();
  randomSeed(50);
}

void mousePressed() {
  if (looping)    noLoop();
  else            loop();
  controlPoint2.x = mouseX;
  controlPoint2.y = mouseY;
  
}


void draw(){
  background(255);
  drawGraph();
  //PImage img = loadImage("./patterns/17.jpg");
  //beginShape();
  //textureMode(NORMAL);
  //texture(img);
  //vertex(0, 0, 0, 0);
  //vertex(width, 0, 1, 0);
  //vertex(width, height, 1, 1);
  //vertex(0, height, 0, 1);
 //endShape();
  Pedal pedal1 = new Pedal(50, 400, 600, 50, 600, 900, true, 10, true);
  AsymetricPedal pedal2 = new AsymetricPedal(50, 200, 50, 750, 600, 50, controlPoint2.x, controlPoint2.y, true, 10, true);
  pedal2.show();
  //pedal1.showStagnated();
  noLoop();
}
