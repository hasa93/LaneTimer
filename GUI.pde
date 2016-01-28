
import controlP5.*;

class GUIElement
{
  private Timer timer;
  private float w, h;
  private int clr = 255;
  
  public GUIElement(Timer timer, float w, float h)
  {
    this.timer = timer;
    this.h = h;
    this.w = w;     
  }
  
  public void SetColor(int c)
  {
    clr = c;
  }
  
   
  public void DrawElement()
  {
    int id = timer.GetLaneId();
    
    fill(clr);
    textAlign(LEFT);
    textSize(dw * 0.2);
    text("Lane " + (id + 1), w * (0.25 + id), h * 0.10);    
    text("Cycle:" + timer.GetCurrTask(), w * (0.3 +  id), h * 0.25);
    
    DrawTime(w * (0.5 + id), h * 0.5);    
        
  }
  
  private void DrawTime(float x, float y)
  {
    int seconds, mill;
    
    float time = timer.GetRemaining();
    
    mill = int(time % 1000.0f);
    seconds = int(time / 1000.0f);
    
    textAlign(CENTER);
    
    textSize(w * 0.6);
    text("" + seconds, x, y);
    
    textSize(w * 0.3);
    text("" + mill, x, y + 100);
 }

}