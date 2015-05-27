import processing.core.*;
import java.io.PrintWriter;
import java.util.*;

class SvgStippleWriter {  
  public static SvgStippleWriter getInstance() {
    if( instance == null ) {
      instance = new SvgStippleWriter();
    }
    return instance;
  }
  
  void printStipples( PrintWriter output, 
                      List<Stipple> stipples ) {
    output.println("<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">");
    
    for( int i = 0; i < stipples.size(); i++ ) 
    {
      Stipple s = stipples.get(i);
      output.println("<circle cx=\"" + s.location.x + 
              "\" cy=\"" + s.location.y + 
              "\" r=\"" + s.size + 
              "\" fill=\"black\" />");
    }
    output.println("</svg>");
    output.flush();
    output.close();
    System.exit(0); 
  }

  private static SvgStippleWriter instance; 
}


