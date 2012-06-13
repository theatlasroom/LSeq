class GeometryProcessor implements SequenceProcessor {
  //this is a class for simple 2d geometry processing
  private int total_actions = 8, total_steps;
  private final int NULL_STEP = -1, DRAW_LINE = 0, DRAW_RECT = 1, DRAW_CIRC = 2, DRAW_CURVE = 3, ROT_LEFT = 4, ROT_RIGHT = 5, FILL_CANVAS = 6, CLEAR_CANVAS = 7; 
  private int[] action_chain;
  //public constructor
  public GeometryProcessor(int total_steps){
    this.total_steps = total_steps;
    this.action_chain = new int[this.total_steps];
    for (int i=total_steps-1;i>0;i--)
      this.action_chain[i] = -1;
  }
  
  //interface methods
  public void SetStep(int step, int state){
    //set the state of the current step
    state %= total_actions;
    this.action_chain[step%total_steps] = state;
    println("Set state of step " + step + " to " + state);
  }
  
  public void ProcessStep(int step){
    //process the action at the current step
    if (this.action_chain[step] > 0);
      this.Render(this.action_chain[step]);    
  }
  
  public void Render(int step){
    fill(0);
    stroke(255);
    switch(step){
      case DRAW_LINE: 
        DrawLine();
        break;
      case DRAW_RECT: 
        DrawRect();
        break;
      case DRAW_CIRC: 
        DrawCirc();
        break;
      case DRAW_CURVE: 
        DrawCurve();
        break;
      case ROT_LEFT: 
        RotLeft();
        break;
      case ROT_RIGHT: 
        RotRight();
        break;
      case FILL_CANVAS: 
        FillCanvas();
        break; 
      default:
        ClearCanvas();
        break;      
    }    
  }
  
  //Define all the actions
  public void DrawLine(){
    float start_x = random(width), start_y = random(height), end_x = random(width), end_y = random(height);  
    //draw a random line at a point
    line(start_x, start_y, end_x, end_y);
  }  
   
  public void DrawRect(){
    rect(0, 0, random(width), random(height));    
  } 
  
  public void DrawRect(int col){
    fill(col);
    rect(0, 0, width, height);    
  }
  
  public void DrawCirc(){
    float start_x = random(width), start_y = random(height), end_x = random(width), end_y = random(height);  
    //draw a random line at a point
    line(start_x, start_y, end_x, end_y);
  }
  
  public void DrawCurve(){
    float start_x = random(width), start_y = random(height), end_x = random(width), end_y = random(height);  
    //draw a random line at a point
    line(start_x, start_y, end_x, end_y);
  } 
    
  public void RotLeft(){
    float start_x = random(width), start_y = random(height), end_x = random(width), end_y = random(height);  
    //draw a random line at a point
    line(start_x, start_y, end_x, end_y);
  }
  
  public void RotRight(){
    float start_x = random(width), start_y = random(height), end_x = random(width), end_y = random(height);  
    //draw a random line at a point
    line(start_x, start_y, end_x, end_y);
  }
  
  public void FillCanvas(){
    this.DrawRect(255);
  }    
  
  public void ClearCanvas(){
    this.DrawRect(0);
  }  
}
