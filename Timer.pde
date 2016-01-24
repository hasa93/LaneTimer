class Timer
{
  private FloatList t_que = new FloatList();
  private float t_rem;
  private int lane_id;
  private int curr_task;
  private Boolean isPaused = false;
 
  public Timer(int lane_id)
  {
   this.lane_id = lane_id;
   this.t_rem = 0.0f;
   this.curr_task = 0;
  }
  
  public void PushTime(float seconds)
  {
    t_que.append(seconds);
    StartTimer();
  }
  
  public void ResetCurrent()
  {
    t_rem = t_que.get(t_que.size() - 1);
  }
  
  public void ResetTimer()
  {
    t_que.clear();
    t_rem = 0.0f;
  }
  
  public void StartTimer()
  {
    if(t_rem == 0 && t_que.size() > 0)
    {
      t_rem = t_que.get(0);
    }
    
    isPaused = false;    
  }
  
  public void UpdateTimer(float dt)
  {
    if(!isPaused)
    {
      t_rem -= dt;      
    }
    
    if(t_rem < 0)
    {
      if(t_que.size() > 0)
      {
        t_rem = t_que.get(0);
        t_que.remove(0);
        curr_task++;
      }
      else
      {
        t_rem = 0.0f;
        isPaused = true;
      }
    }
    
    if(t_que.size() > 0 && t_rem < 0)
    {
      t_rem = t_que.get(0);
      t_que.remove(0);
    }    
    else if(t_que.size() == 0 && t_rem < 0)
    {
      isPaused = true;
    }
    
  }
  
  public void PauseTimer()
  {
    isPaused = true;
  }
  
  public float GetRemaining()
  {
    return t_rem;
  }
  
  public float GetLaneId()
  {
    return lane_id;
  }
  
  public FloatList GetTasks()
  {
    return t_que;
  }
    
  public Boolean IsRunning()
  {
    return !isPaused;
  }
  
  public int GetCurrTask()
  {
    return curr_task;
  }  
 
}