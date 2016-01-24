class TimerController
{
  private ArrayList<Timer> timers = new ArrayList<Timer>();
  private float prevTime;
  
  public TimerController()
  {
    prevTime = 0.0f;
  }
  
  public ArrayList<Timer> GetTimers()
  {
    return timers;
  }
 
  public void PushTimer(Timer timer)
  {
    timers.add(timer);
  }
  
  public void RemoveTimer(int timer_id)
  {
    timers.remove(timer_id);
  }
  
  public void PushTask(int timer_id, float task_time)
  {
    timers.get(timer_id).PushTime(task_time);
  }
  
  public void PauseTimer(int timer_id)
  {
    timers.get(timer_id).PauseTimer();
  }
  
  public void StartTimer(int timer_id)
  {
    timers.get(timer_id).StartTimer();
  }
  
  public void ResetTimer(int timer_id)
  {
    timers.get(timer_id).ResetCurrent();
  }
  
  public Timer GetTimer(int i)
  {
    return timers.get(i);
  }
  
  public int GetTimerCount()
  {
    return timers.size();
  }  
  
  public void UpdateTimers(float elapsed)
  {
    for(int i = 0; i < timers.size(); i++)
    {
      timers.get(i).UpdateTimer(elapsed - prevTime);
    }
    
    prevTime = elapsed;
  }
}