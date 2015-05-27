import processing.core.*;
import java.lang.Math;

class ShapeRender {
  
  // Singleton shape render
  public static ShapeRender getInstance() {
    if( instance == null ) {
      instance = new ShapeRender();
    }
    return instance;
  }
  
  public void drawCylinder(PGraphics pg, 
                    int sides, 
                    float topSize, 
                    float bottomSize, 
                    float h) {
  
    float angle = 360 / sides;
    float halfHeight = h / 2;
  
    // topShape
    pg.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = (float)Math.cos( Math.toRadians( i * angle ) ) * topSize;
      float y = (float)Math.sin( Math.toRadians( i * angle ) ) * topSize;
      pg.vertex(x, y, halfHeight);
    }
    pg.endShape(pg.CLOSE);
  
    pg.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = (float)Math.cos( Math.toRadians( i * angle ) ) * bottomSize;
      float y = (float)Math.sin( Math.toRadians( i * angle ) ) * bottomSize;
      pg.vertex(x, y, -halfHeight);
    }
    pg.endShape(pg.CLOSE);
  
    pg.beginShape(pg.TRIANGLE_STRIP);
    for (int i = 0; i <= sides; i++) {
      float x1 = (float)Math.cos( Math.toRadians( i * angle ) ) * topSize;
      float y1 = (float)Math.sin( Math.toRadians( i * angle ) ) * topSize;
      float x2 = (float)Math.cos( Math.toRadians( i * angle ) ) * bottomSize;
      float y2 = (float)Math.sin( Math.toRadians( i * angle ) ) * bottomSize;
      pg.vertex(x1, y1, halfHeight);
      pg.vertex(x2, y2, -halfHeight);
    }
    pg.endShape(pg.CLOSE);
  }
  
  public void drawCone(PGraphics pg, 
                int size, 
                float bottomSize, 
                float h)
  {
    drawCylinder(pg, 
    size, /* sides */
    0, /* topsize */ 
    bottomSize, /* bottom */
    h  /* height */);
  }
  
  
  private static ShapeRender instance = null;
}

