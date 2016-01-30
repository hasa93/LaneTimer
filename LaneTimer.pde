import controlP5.*;
import java.util.*;

TimerController t_ctrl = new TimerController();

ControlP5 cp5;
GUIPane[] pane;
TimerDialog t_dlg;

ControlGroup t_pusher;

int dw;
int n = 6;
boolean selectMode = false;

void setup()
{
  size(800, 600);
  //fullScreen();
  background(#00A8FF);  
  smooth();
  
  dw = width / n;
  
  cp5 = new ControlP5(this);
  
  t_dlg = new TimerDialog(cp5);
  pane = new GUIPane[n];
  
  SetUpTimers();
  
}

void draw()
{
  clear();
  background(#00A8FF); 
  fill(0);
  
  t_ctrl.UpdateTimers(millis());

   for(int i = 0; i < n; i++)
  {
    pane[i].UpdatePane();
    pane[i].DrawPane();
  }
}

void SetUpTimers()
{  
  for(int i = 0; i < n; i++)
  {
    Timer t = new Timer(i);
    t_ctrl.PushTimer(t);
    pane[i] = new GUIPane(t, cp5, dw, height);    
  }
  
  //Timer for handling lane groups
  t_ctrl.PushTimer(new Timer(n)); 
}


void mouseClicked()
{
  int id = mouseX / dw; 
  
  if(mouseButton == RIGHT)
  {
    t_ctrl.ClearTimer(id);
  }
  
  if(selectMode)
  {
    if(pane[id].isSelected())
    {
      pane[id].SetSelected(false);
      pane[id].SetTimer(t_ctrl.GetTimer(id));
    }
    else
    {
      pane[id].SetSelected(true);
      pane[id].SetTimer(t_ctrl.GetTimer(n));
    }
  }
}


void keyPressed()
{
  if(key == CODED)
  {
    if(keyCode == SHIFT)
    {
       selectMode = true;       
    }
  }
  else if(key == ESC)
  {
    exit();
  }
}

void keyReleased()
{
  selectMode = false;
}
  
public void sub_task_que(int n)
{
  ScrollableList sc = cp5.get(ScrollableList.class, "sub_task_que");
   
  String name = sc.getItem(n).get("name").toString();
  sc.removeItem(name);  
}

public void controlEvent(ControlEvent event)
{
  
  if(event.isController())
  {      
    Controller trigger = event.controller();
           
    int id = int(trigger.getValue());
       
      
    if (trigger.getLabel() == "Start" || trigger.getLabel() == "Pause")
    {
      pane[id].ToggleResponse();
    }
    
    else if (trigger.getLabel() == "Reset")
    {
      pane[id].ResetResponse();
    }
    
    else if(trigger.getLabel() == "Add")
    {
      pane[id].AddResponse(t_dlg);
    }
    
    else if(trigger.getName() == "addTime")
    {
      t_dlg.GetInput();
    }
    
    else if(trigger.getName() == "finishAdd")
    {
      t_dlg.PushToTimer(t_ctrl);
      cp5.get(ControlGroup.class, "add_task").setVisible(false);      
    }
    
  }
}