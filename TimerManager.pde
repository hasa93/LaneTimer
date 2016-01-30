import controlP5.*;

class TimerDialog
{
  private ControlP5 cp5;
  private int timer_id = 0;
   
  public TimerDialog(ControlP5 cp5)
  {
    this.cp5 = cp5;
    CreateAddDialog();
  }
  
  public void SetCallerId(int timer_id)
  {
    this.timer_id = timer_id;
  }
  
  private void CreateAddDialog()
  {
    cp5.addGroup("add_task")
        .setPosition(width * 0.375, height * 0.375)
        .setWidth(width / 2)
        .setLabel("PushTask")
        .setBackgroundColor(#090062)
        .setBackgroundHeight(height / 5)
        .activateEvent(true)
        .setVisible(false);
    
    cp5.addTextfield("minutes")
       .setPosition(140, 10)
       .setSize(50, 30)
       .setFont(createFont("arial", 12))
       .setAutoClear(true)
       .setText("00")
       .setInputFilter(Textfield.INTEGER)
       .setGroup("add_task");
    
    cp5.addTextfield("seconds")
       .setPosition(201, 10)
       .setSize(50, 30)
       .setFont(createFont("arial", 12))
       .setAutoClear(true)
       .setText("00")
       .setInputFilter(Textfield.INTEGER)
       .setGroup("add_task");
       
    cp5.addTextfield("times")
       .setPosition(201, 60)
       .setSize(50, 30)
       .setFont(createFont("arial", 12))
       .setAutoClear(true)
       .setText("1")
       .setInputFilter(Textfield.INTEGER)
       .setGroup("add_task");
    
    cp5.addButton("finishAdd")
      .setPosition(260, 60)
      .setSize(70, 30)
      .setLabel("Finish")
      .setId(10)
      .setGroup("add_task")
      .setColorBackground(#2CA505); 
      
    cp5.addButton("addTime")
      .setPosition(260, 10)
      .setSize(70, 30)
      .setLabel("Add Cycle")
      .setId(9)
      .setGroup("add_task")
      .setColorBackground(#FF0353);    
      
    cp5.addScrollableList("sub_task_que")
       .setPosition(10, 10)
       .setWidth(116)
       .setBarHeight(20)
       .setItemHeight(15)
       .setLabel("Cycle que")
       .setType(ScrollableList.LIST)
       .setId(11)
       .setGroup("add_task");       
  }
  
  public void GetInput()
  {
    String minutes = cp5.get(Textfield.class, "minutes").getText();
    String seconds = cp5.get(Textfield.class, "seconds").getText();
    
    float millis = 1000 * (float(minutes) * 60 + float(seconds));
      
    cp5.get(ScrollableList.class, "sub_task_que").addItem(minutes + ":" + seconds, millis);
  }
  
  public void PushToTimer(TimerController t)
  {
    ScrollableList sc = cp5.get(ScrollableList.class, "sub_task_que");
      
    int i = int(cp5.get(Textfield.class, "times").getText());      
    int q_size = sc.getItems().size();
    
    for(i = i * q_size; i > 0; i--)
    {
      float time = (float) sc.getItem(i % q_size).get("value");
      t.PushTask(timer_id, time);
    }
    
    sc.clear();    
  }
}