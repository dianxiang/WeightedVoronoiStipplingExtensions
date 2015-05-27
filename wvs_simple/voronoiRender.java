import processing.core.*;

class VoronoiRender {  
  public static VoronoiRender getInstance() {
    if( instance == null ) {
      instance = new VoronoiRender();
    }
    return instance;
  }
  
  public void drawVoronoiCone(PGraphics pg, 
                               PVector pos, 
                               float angle, 
                               float h)
  {
    pg.pushMatrix();
    pg.translate(pos.x + 0.5f, pos.y + 0.5f);
    ShapeRender.getInstance().drawCone(
        pg, 
        VORONOI_CONE_SIZE, 
        (float)(h * Math.tan( Math.toRadians(angle)) ), 
        h);
    pg.popMatrix();
  }
  
  private static VoronoiRender instance; 
  private static final int VORONOI_CONE_SIZE = 20; 
}
