class Timer
{
  private FloatList t_que = new FloatList();
  private float t_rem;
  private int lane_id;
  private int curr_task;
  private boolean isPaused = true;
 
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
    t_rem = t_que.get(curr_task - 1);
    isPaused = true;    
  }
  
  public void ClearTimer()
  {
    isPaused = true;
    
    t_que.clear();
    t_rem = 0.0f;
    curr_task = 0;
  }
  
  public void StartTimer()
  {
    if(t_rem <= 0 && curr_task < t_que.size())
    {
      t_rem = t_que.get(curr_task);
      curr_task++;
    }
    
    isPaused = false;    
  }
  
  public void UpdateTimer(float dt)
  {    
    if(t_rem < 0)
    {             
      if(curr_task < t_que.size())
      {
        t_rem = t_que.get(curr_task);
      
        curr_task++;
      }
      else
      {
        t_rem = 0.0f;
        isPaused = true;
      }
    }
    else if(!isPaused)
    {
       t_rem -= dt;
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
  
  public int GetLaneId()
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