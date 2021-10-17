float inc = 0.4;
float zoff = 0.1;
int scl = 20;
int cols, rows;
PVector v = new PVector();
int n = 10;
Particle[] particles = new Particle[n];
PVector[] flowField;

void setup() {
  size(400, 400);
  cols = floor(width/scl);
  rows = floor(height/scl);
  flowField = new PVector[cols * rows];
  for (int i = 0; i<n; i++){
    particles[i] = new Particle();
  }
}

void mousePressed() {
  if (looping)    noLoop();
  else            loop();
}

// Noise function space is ([0:1.9], [0:1.9], [0.1, inf))
// Noise function space not equal to grid space which is 20x20 with resolution 20 per grid square aka 400 x 400 total pixel 

void draw(){
  background(255);
  randomSeed(20);
  float yoff = 0;
  for (int y = 0; y < rows; y++){
    float xoff = 0;
    for (int x = 0; x < cols; x++){
      int index = x + y * cols;                    // Find index of vector aka which 20x20 square vector is in
      float r = noise(xoff, yoff, zoff) * 255;     // calculate color based of noise (0-1) then multiply by 255 to get in range of [0,255]
      float angle = noise(xoff, yoff, zoff) *0.5*PI;  // get noise in range of 90-1 then multiply by PI to get an angle from 0 to 180 degrees
      fill(r);                                     // set fill color to r
      //rect(x*scl, y*scl, scl, scl);                // draw filled in rectangle for x,y index that goes to next angle border (resolution of 20) 
      v = v.fromAngle(angle);                      // calculate Pvector from angle
      flowField[index] = v;                        // Set flowfield at index to vector
      stroke(50, 50);                              // set stroke rgb and alpha
      push();                                      // push stroke to stack
      translate(x*scl, y*scl);                     // translate to porper position by multiply x,y index by scale 
      rotate(v.heading());                         // rotate according to Pvector v heading angle
      line(0,0,scl, 0);                            // Draw line length of fidelity of grid
      pop();                                       // pop previous transformations from the fraw stack
      xoff +=inc;                                  // increment xoff for noise function after
    }
    yoff+=inc;                                     //inc yoff for noise function
    zoff += 0.001;                                 // inc z off for noise function: gives impression of movng through z plane of noise function
  }
  for (int i =0; i < particles.length; i++){
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].edges();
    particles[i].show();
    
  }
}
