import java.util.ArrayList;

public class Particle {
 public PVector pos;
 public PVector vel;
 public PVector acc;
 public float maxSpeed;
 public ArrayList<PVector> history;
 public int historyLength;
 
 public Particle() {
   this.pos = new PVector(random(width),random(height));
   this.vel = new PVector(random(1),random(1));
   this.acc= new PVector(0,0);
   this.maxSpeed = 4;
   
   this.history = new ArrayList<PVector>(0);
   this.historyLength=20;
 }
 
 public void update() {
   this.pos.add(this.vel);
   this.vel.add(this.acc);
   this.vel.limit(this.maxSpeed);
   this.acc.mult(0);
   
   this.history.add(new PVector(this.pos.x, this.pos.y));
   if (this.history.size()>this.historyLength){
     this.history.remove(0);
   }
   
 }
 
 public void applyForce(PVector force) {
   this.acc.add(force);
 }
 
 public void tailV1() {
   push();
   strokeWeight(5);
   for (int i =0; i<this.history.size();i++){
     stroke(0, i * 12.75);
     PVector position = this.history.get(i);
     strokeWeight(i/2);
     point(position.x, position.y);
   }
   pop();
 }
 
 // handles drawingVertex where particle leaves edge of screen
 public void tailV2() {
   push();
   strokeWeight(5);
   noFill();
   beginShape();
   for (int i =0; i<this.history.size();i++){
     stroke(0, i * 12.75);
     PVector position = this.history.get(i);
     PVector nextPosition;
     strokeWeight(1);
     
     curveVertex(position.x, position.y);
     
     if (i != this.history.size()-1) {
       nextPosition = this.history.get(i+1);
       if (nextPosition.x< position.x || nextPosition.y < position.y ){
          endShape();
          beginShape();
       }
     }
   }
   endShape();
   pop();
 }
 
 // This is broken
 public void tailV3() {
   push();
   strokeWeight(5);
   stroke(0, 255);
   noFill();
   beginShape();
   PVector firstPosition = this.history.get(0);
   curveVertex(10, 20);
   if (this.history.size()-1 >= this.historyLength/2){
     PVector secondPosition = this.history.get(this.historyLength/2);
     curveVertex(30, 40);
   }
   if (this.history.size()-1 >= this.historyLength){
     PVector thirdPosition = this.history.get(this.historyLength);
     curveVertex(89, 34);
   }
   endShape();
   pop();
 }
 
 public void show() {
   this.tailV2();
 }
 
 
 public void edges(){
   if (this.pos.x > width) this.pos.x=0;
   if (this.pos.x < 0) this.pos.x=width-.01;
   if (this.pos.y > height) this.pos.y=0;
   if (this.pos.y < 0) this.pos.y=height-.01;
 }
 
 public void follow(PVector[] vectors){
   int x = floor(this.pos.x /scl);
   int y = floor(this.pos.y /scl);
   int index = x + y * cols;
   PVector force = vectors[index];
   this.applyForce(force);
 }
}
