public class AsymetricPedal {
 public PVector origin;
 public PVector anchor;
 public PVector control1;
 public PVector control2;
 public int recurseDepth;
 public boolean renderControls;
 
 public AsymetricPedal(float originX, float originY, float anchorX, float anchorY, float control1X, float control1Y, float control2X, float control2Y, boolean randRecurse, int recurseDepth, boolean renderControls) {
   this.anchor= new PVector(anchorX, anchorY);
   this.control1= new PVector(control1X, control1Y);
   this.control2= new PVector(control2X, control2Y);
   if (randRecurse){
     this.recurseDepth = 1 + floor(random(recurseDepth));
   }
   this.renderControls = renderControls;
   println(this.recurseDepth);
   this.origin = new PVector(originX, originY);
 }
 
 public void renderControlPoints(PVector controla, PVector controlb){
   push();
   // Control Point 1
   stroke(255, 0, 0);
   strokeWeight(8);
   point(controla.x, controla.y);
   strokeWeight(1);
   line(this.origin.x, this.origin.y, this.control1.x, this.control1.y);
   
   // Control Point 2
   stroke(0, 255, 0);
   strokeWeight(8);
   point(controlb.x, controlb.y);
   strokeWeight(1);
   line(this.anchor.x, this.anchor.y, control2.x, control2.y);
   
   // Origin
   stroke(0, 255, 255);
   strokeWeight(8);
   point(this.origin.x, this.origin.y);
   
   // Anchor
   stroke(0, 0, 255);
   strokeWeight(8);
   point(this.anchor.x, this.anchor.y);
   pop();
 }

 
 public void showStagnated() {
   push();
   //Bezier Curve
   PVector control1Shift = new PVector(control1.x/recurseDepth, control1.y/recurseDepth);
   PVector control2Shift = new PVector(control2.x/recurseDepth, control2.y/recurseDepth);
   PVector controla = new PVector(this.control1.x,this.control1.y);
   PVector controlb = new PVector(this.control2.x,this.control2.y);
   
   for (float i = 0; i < recurseDepth; i++ ){
     
     controla.sub(control1Shift);
     controlb.sub(control2Shift);
     
     if (this.renderControls){
      this.renderControlPoints(controla, controlb);
     }
     
     stroke(0);
     noFill();
     strokeWeight(1);
     beginShape();
     vertex(this.anchor.x, this.anchor.y);
     bezierVertex(controla.x, controla.y, controlb.x, controlb.y, this.anchor.x, this.anchor.y);
     endShape();
   }
   pop();
 }
 
 public void show() {
   push();
    
   //Bezier Curve
   // Subtract the control from the anchor to get the vector between the 2 and divide by recursive depth to get the propr spacing between bezier curves
   PVector control1Shift = new PVector((this.control1.x - this.origin.x)/recurseDepth, (this.origin.y - this.anchor.y)/recurseDepth);
   PVector control2Shift = new PVector((this.control2.x - this.anchor.x)/recurseDepth, (this.control2.y - this.anchor.y)/recurseDepth);
   
   // Make new vectors we can modify in each step of the loop
   PVector controla = new PVector(this.control1.x,this.control1.y);
   PVector controlb = new PVector(this.control2.x,this.control2.y);
   
   for (float i = 0; i < recurseDepth; i++ ){
     
     // PVector function like sub operate on the original vector, not returning something new
     controla.sub(control1Shift);
     controlb.sub(control2Shift);
     
     stroke(0);
     random(50);
     noFill();
     strokeWeight(1);
     beginShape();
     vertex(this.origin.x, this.origin.y);
     bezierVertex(controla.x, controla.y, controlb.x, controlb.y, this.anchor.x, this.anchor.y);
     endShape();
   }
   if (this.renderControls){
     println("trigger");
     this.renderControlPoints(this.control1, this.control2);
   }
   pop();
 }
}
