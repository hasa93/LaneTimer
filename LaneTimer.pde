import controlP5.*;
import java.util.*;

TimerController t_ctrl = new TimerController();
GUIElement[] elems;
ControlP5 cp5;

ControlGroup t_pusher;

int dw;
int n = 6;

void setup()
{
  size(800, 600);
  //fullScreen();
  background(#00A8FF);  
  smooth();
  
  dw = width / n;
  
  cp5 = new ControlP5(this);
  elems = new GUIElement[n];
  
  SetUpTimers();
  
}

void draw()
{
  clear();
  background(#00A8FF); 
  fill(0);
 
  t_ctrl.UpdateTimers(millis());

  DrawLanes();
}

void SetUpTimers()
{  
  for(int i = 0; i < n; i++)
  {
    Timer t = new Timer(i);
    t_ctrl.PushTimer(t);
    elems[i] = new GUIElement(t, dw, height);
    
    cp5.addButton("p/r" + i)
      .setPosition(dw * (0.6 +  i), height / 5 * 4)
      .setSize(40, 40)
      .setId(i)
      .setLabel("Pause");
      
    cp5.addButton("reset" + i)
      .setPosition(dw * (0.2 + i), height / 5 * 4)
      .setSize(40, 40)
      .setId(255 + i)
      .setLabel("Reset");
    
  }
  
  createPusher();
  
  t_ctrl.PushTask(0, 7200);
  t_ctrl.PushTask(0, 7500); 
  t_ctrl.PushTask(1, 8500);
}

void createPusher()
{
  cp5.addGroup("pusher")
       .setPosition(width * 0.375, height * 0.375)
       .setWidth(width / 4)
       .setLabel("PushTask")
       .setBackgroundColor(#090062)
       .setBackgroundHeight(70)
       .activateEvent(true);
    
    cp5.addTextfield("minutes")
       .setPosition(10, 10)
       .setSize(50, 30)
       .setFont(createFont("arial", 20))
       .setGroup("pusher");
    
    cp5.addTextfield("seconds")
       .setPosition(66, 10)
       .setSize(50, 30)
       .setFont(createFont("arial", 20))
       .setGroup("pusher");
       
    cp5.addButton("addTime")
      .setPosition(121, 10)
      .setSize(70, 30)
      .setLabel("Add")
      .setId(100)
      .setGroup("pusher")
      .setColorBackground(#FF0353);     
}

void DrawLanes()
{
 
  fill(255);
  
  for(int i = 0; i < n; i++)
  {
    elems[i].DrawElement();
  }
}


void processMouse()
{
  int id = mouseX / dw;  
  elems[id].SetColor(#59FF08);
}

public void ProcessAddTask(ControlEvent event)
{
  if(event.controller().getId() == 100)
  {
    println("Received event from add task!");
  }
  
}

public void controlEvent(ControlEvent event)
{
  ProcessAddTask(event);
  
  if(event.isController())
  {
    int id = event.controller().getId();
    
    if (id < 7)
    {
      Timer t = t_ctrl.GetTimer(id);
    
      if(t.IsRunning()) 
      {
        t.PauseTimer();
        event.controller().setLabel("Run");
      }
      else 
      {
        t.StartTimer();
        event.controller().setLabel("Pause");
      }
    }
    else if (id >= 255)
    {
      id -= 255;
      
      Timer t = t_ctrl.GetTimer(id);
      t.ResetCurrent();
      cp5.get(Button.class, "p/r" + id).setLabel("Run"); 
    }
    
  }
}