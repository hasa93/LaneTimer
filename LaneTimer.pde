import controlP5.*;
import java.util.*;

TimerController t_ctrl = new TimerController();
ControlP5 cp5;

void setup()
{
  size(600, 400);
  //fullScreen();
  background(255);  
  
  cp5 = new ControlP5(this);
  //gui();
  SetUpTimers();
}

void draw()
{
  t_ctrl.UpdateTimers(millis()); 
  
  clear();
  background(255);
  fill(0);
  
  t_ctrl.UpdateTimers(millis());
  DrawLanes();
}

void SetUpTimers()
{
  t_ctrl.PushTimer(new Timer(0));
  t_ctrl.PushTimer(new Timer(1));
  t_ctrl.PushTimer(new Timer(2));
  
  t_ctrl.PushTask(0, 7200);
  t_ctrl.PushTask(0, 7500); 
}

void DrawLanes()
{
  int n = t_ctrl.GetTimerCount();;  
  
  int dw = width / n;
  
  fill(0);
  
  for(int i = 0; i < n; i++)
  {
    
    text("Lane " + (i + 1), 30 + dw * i, 10);
    text("Lap:" + t_ctrl.GetTimer(i).GetCurrTask(), 50 + dw * i, height * 0.25);
    text(t_ctrl.GetTimer(i).GetRemaining() , 10 + dw * i, height * 0.5);     
  }
}

void gui()
{
  cp5.addScrollableList("dropdown")
     .setPosition(100, 100)
     .setSize(200, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(ToStringArray(t_ctrl.GetTimer(0).GetTasks()));
}

String[] ToStringArray(FloatList lst)
{
  String[] out = new String[lst.size()];
  
  for(int i = 0; i < lst.size(); i++)
  {
    out[i] = str(lst.get(i));
  }
  
  return out;
}