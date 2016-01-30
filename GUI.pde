
import controlP5.*;

class GUIPane
{
  private Timer timer;
  private float w, h;
  private int clr = 255;
  private boolean isSelected = false;
  private int PaneId;
  
  public GUIPane(Timer timer, ControlP5 cp5, float w, float h)
  {
    this.timer = timer;
    this.h = h;
    this.w = w;    
    
   PaneId = timer.GetLaneId();
    
    cp5.addButton("p/r" + PaneId)
      .setPosition(dw * (0.6 +  PaneId), height * 0.8)
      .setSize(40, 40)
      .setValue(PaneId)
      .setLabel("Start");
      
    cp5.addButton("Reset" + PaneId)
      .setPosition(dw * (0.2 + PaneId), height * 0.8)
      .setSize(40, 40)
      .setValue(PaneId)
      .setLabel("Reset");
    
   cp5.addButton("Push" + PaneId)
      .setPosition(dw * (0.4 + PaneId), height * 0.88)
      .setSize(40, 40)
      .setValue(PaneId)
      .setColorBackground(#FF0088)
      .setLabel("Add");    
  }
  
  public void SetColor(int c)
  {
    clr = c;
  }
  
  public void SetTimer(Timer timer)
  {
   this.timer.PauseTimer();
   this.timer = timer;
  }
      
  public boolean isSelected()
  {
    return isSelected;
  }
  
  public void SetSelected(boolean value)
  {
    isSelected = value;
  }
  
  public void ToggleResponse()
  {
    if(timer.IsRunning())
    {
      timer.PauseTimer();
    }
    else
    {
      timer.StartTimer();
    }
  }
  
  public void ResetResponse()
  {
    timer.ResetCurrent();
  }
  
  public void AddResponse(TimerDialog dlg)
  {
    dlg.SetCallerId(timer.GetLaneId());
    cp5.get(ControlGroup.class, "add_task").setVisible(true);
  }
  
  public void UpdatePane()
  {
    String label;
    
    if(timer.IsRunning())
    {
      label = "Pause";
    }
    else
    {
      label = "Start";
    }
    
    cp5.get(Button.class, "p/r" + PaneId).setLabel(label);
    
  }
  
  public void DrawPane()
  {
       
    if(isSelected) clr = #FEFF00;
    else clr = 255;
    
    fill(clr);
    textAlign(LEFT);
    textSize(dw * 0.2);
    text("Lane " + (PaneId + 1), w * (0.25 + PaneId), h * 0.10);    
    text("Cycle:" + timer.GetCurrTask(), w * (0.3 +  PaneId), h * 0.25);
    
    DrawTime(w * (0.5 + PaneId), h * 0.5);    
        
  }
  
  private void DrawTime(float x, float y)
  {
    int seconds, mill;
    
    float time = timer.GetRemaining();
    
    mill = int(time % 1000.0f);
    seconds = int(time / 1000.0f);
    
    textAlign(CENTER);
    
    textSize(w * 0.6);
    
    if(seconds == 0 && timer.IsRunning())
    {
      fill(255, 0, 0);
      text("GO", x, y);
      fill(255);
    }
    else
    {
      text("" + seconds, x, y);
    }
          
    textSize(w * 0.3);
    text("" + mill, x, y + 100);
 }
  
}