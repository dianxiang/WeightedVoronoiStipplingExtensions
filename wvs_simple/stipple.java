import processing.core.*;

class Stipple {
  public Stipple() {
    location = new PVector(0, 0);
    fixed = false;
    moveFrame = false;
    size = DEFAULT_STIPPLE_SIZE;
    voronoiCenter = new PVector(0, 0);
    voronoiCount = 0.0f;
  }
  
  public Stipple(int x, int y) {
    location = new PVector(x, y);
    fixed = false;
    moveFrame = false;
    size = DEFAULT_STIPPLE_SIZE;
    voronoiCenter = new PVector(x, y);
    voronoiCount = 0.0f;
  }
  
  public Stipple(int x, int y, Boolean fix) {
    location = new PVector(x, y);
    fixed = fix;
    moveFrame = false;
    size = DEFAULT_STIPPLE_SIZE;
    voronoiCenter = new PVector(x, y);
    voronoiCount = 0.0f;
  }
  
  public void resetVoronoiCalculations() {
    voronoiCenter.x = 0;
    voronoiCenter.y = 0;
    voronoiCount = 0.0f;
  }
  
  public void setCount(float count) {
    voronoiCount = count;
  }
  
  public PVector location;
  public Boolean fixed;
  public Boolean moveFrame;
  public Float size;
  
  public PVector voronoiCenter;
  public Float voronoiCount;
  
  private static final float DEFAULT_STIPPLE_SIZE = 3.0f;
};
