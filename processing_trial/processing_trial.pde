void setup() {
  size(500, 500, P3D);
}

void draw() {
  if (mousePressed) {
    fill(0);
  } else {
    fill(255);
  }
  
  ellipse(mouseX, mouseY, 80, 80);
}

boolean rand = false;
void mousePressed() {
  translate(50, 50);
  if(!rand) {
    pushMatrix();
  } else {
    popMatrix();
  }
  
  rand = !rand;
  
  background(0, 0, 0);
}
