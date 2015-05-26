PImage img;

void setup() {
  size(500, 500);
  img = loadImage("pikachu.png");
}

void draw() {
  background(0);
  image(img, 0, 0);
}

