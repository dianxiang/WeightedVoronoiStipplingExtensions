import processing.pdf.*;
import java.util.*;


// Global 
PImage src;
PGraphics voronoiImg;
PrintWriter output;
int brushSize = 20;
Boolean toggleImage = false;

// Constant parameters
int VORONOI_CONE_ANGLE = 50;
int VORONOI_CONE_HEIGHT = 100;
int NUM_INITIAL_STIPPLES = 1000;
String INPUT_FILE = "pikachu.png";
String OUTPUT_FILE = "output.svg";

List<Stipple> stipples;

void initializeStippleLocations(PImage src) {
  stipples = new ArrayList();
  for ( int i = 0; i < NUM_INITIAL_STIPPLES; i++ ) {
    stipples.add(new Stipple((int)random(width), (int)random(height)));
  }
}

void resetVoronoiCalculations() {
  for( int i = 0; i < stipples.size(); i++ ) {
    stipples.get(i).resetVoronoiCalculations();
  }
}

void setup() {
  src = loadImage(INPUT_FILE);
  src.filter(GRAY);
  size(src.width, src.height, P3D);
  voronoiImg = createGraphics(src.width, src.height, P3D);

  output = createWriter(OUTPUT_FILE);
  initializeStippleLocations(src);

  hint(ENABLE_DEPTH_TEST);
}

// TODO: Can move this to a Voronoi class
color getVoronoiColorFromIndex(int index) {
  return color( (index & 255), 
  ((index >> 8) & 255), 
  ((index >> 16) & 255) );
}

// Can move this to a Voronoi class
int getIndexFromVoronoiColor(color c) {
  return ( ((int)blue(c) << 16) | 
           ((int)green(c) << 8) | 
            (int)red(c) );
}

// Can move this to a Voronoi class
void drawVoronoiDiagram(List<Stipple> stipples, 
                        PGraphics voronoiImg) {
  voronoiImg.beginDraw();
  voronoiImg.background(200, 200, 200);
  voronoiImg.noLights();
  voronoiImg.ortho();
  voronoiImg.noStroke();
  voronoiImg.noSmooth();
  src.loadPixels();

  for (int i = 0; i < stipples.size (); i++) {
    PVector p = stipples.get(i).location;
    voronoiImg.fill( getVoronoiColorFromIndex(i) );
    VoronoiRender.getInstance().drawVoronoiCone(voronoiImg, 
                     p, 
                     VORONOI_CONE_ANGLE, 
                     VORONOI_CONE_HEIGHT);
  }

  voronoiImg.endDraw();
}

// Can move this to a Voronoi class
void calculateVoronoiCentroid(List<Stipple> stipples,
                              PGraphics voronoiImg) {
  // Calculating the centroid for each region
  for (int y = 0; y < voronoiImg.height; y++) {
    for (int x = 0; x < voronoiImg.width; x++) {
      int loc = y * voronoiImg.width + x;
      int index = getIndexFromVoronoiColor(voronoiImg.pixels[loc]);
      if (index < 0 || index >= stipples.size()) continue;

      PVector originalValue = stipples.get(index).voronoiCenter;
      float weight = 1-red(src.pixels[loc])/255.0f;
      originalValue.x += (x*weight);
      originalValue.y += (y*weight);

      Float originalCount = stipples.get(index).voronoiCount;
      stipples.get(index).setCount((float)originalCount + (float)weight);
    }
  }

  // Dividing by the weights
  for (int i = 0; i < stipples.size(); i++) {
    PVector p = stipples.get(i).voronoiCenter;
    if (stipples.get(i).fixed && !stipples.get(i).moveFrame) continue;
    if (stipples.get(i).voronoiCount <= 0) continue;
    p.x /= stipples.get(i).voronoiCount;
    p.y /= stipples.get(i).voronoiCount;
  }
}

// (TODO) Can move to a stipple renderer
void drawStipples(List<Stipple> stipples) {
  noStroke();
  background(236, 240, 241);
  for (int i = 0; i < stipples.size (); i++) {
    PVector p = stipples.get(i).location;
    fill(44, 62, 80);
    ellipse(p.x, p.y, stipples.get(i).size, stipples.get(i).size);
  }
}

void updateStippleLocationsWithCentroid(List<Stipple> stipples) {
  // Replacing stipple locations with center locations
  for (int i = 0; i < stipples.size (); i++) {
    PVector centerValue = stipples.get(i).voronoiCenter;
    PVector p = stipples.get(i).location;
    if (stipples.get(i).fixed && !stipples.get(i).moveFrame) continue;
    p.x = centerValue.x;
    p.y = centerValue.y;
    Stipple s = stipples.get(i);
    s.moveFrame = false;
  }
}

void draw() {
  
  drawVoronoiDiagram(stipples, voronoiImg);
  voronoiImg.loadPixels();
  
  resetVoronoiCalculations();
  
  // (TODO) Large hack because of weird draw bug. 
  // Need to think of another way to do this.
  boolean allzero = true;
  for (int y = 0; y < voronoiImg.height; y++) {
    for (int x = 0; x < voronoiImg.width; x++) {
      int loc = y * voronoiImg.width + x;
      if ( voronoiImg.pixels[loc] != 0 ) allzero = false;
    }
  }

  if ( !allzero ) {
    calculateVoronoiCentroid(stipples, voronoiImg);
    
    // Drawing the dots
    clear(); // Clearing the scree first from previous frame
    drawStipples(stipples);
    updateStippleLocationsWithCentroid(stipples);
  }
}

