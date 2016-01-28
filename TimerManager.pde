import controlP5;

class TimerManager
{
  private ControlP5 cp5;
  private Boolean showDialog = false;
  
  public TimerManager(ControlP5 cp5)
  {
    this.cp5 = cp5;
  }
  
  private void CreateManager()
  {
    cp5.addGroup("time-manager")
       .setPosition(width * 0.375, height * 0.375)
       .setWidth(width / 4)
       .setLabel("Add new task")
       .setBackgroundColor(#090062)
       .setBackgroundHeight(70)
       .activateEvent(true);
    
    cp5.addScrollableList("timer-que")
       .setPosition(10, 10)
       .setLabel("Cycle que");      
       
  }
  
  private void CreateAddDialog()
  {
    cp5.addGroup("add-time")
        .setPosition(width * 0.375, height * 0.375)
        .setWidth(width / 4)
        .setLabel("PushTask")
        .setBackgroundColor(#090062)
        .setBackgroundHeight(70)
        .activateEvent(true)
        .setVisible(showDialog);
    
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

}