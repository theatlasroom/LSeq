import com.rngtng.launchpad.*;
import themidibus.*;

class LPadControl {
  //interface for basic control of the launchpad
  private Launchpad pad;
  //a list of consts for each of the possible scene states and the current scene pointer
  private int curr_scene; 
  private final int SEQ_SCENE = -1;
  private int BUTTON_OFF = LColor.OFF, SCENE_ON = LColor.YELLOW_HIGH, STEP_ON = LColor.YELLOW_HIGH, STEP_ON_BEAT = LColor.RED_HIGH;
  
  public LPadControl(Launchpad pad) {
    this.pad = pad;
    this.pad.flashingAuto();  
    this.Flash(); 
  }
  
  
  void SetGrid(int index, byte curr_grid_state){
    //toggle the state of this cell, get the x and y coords from the 1 dimenional index that was passed ie step 9 -> x y pos of (0, 1)
    this.SetGrid(this.StepX(index), this.StepY(index), curr_grid_state);       
  }    
  
  void SetGrid(int x, int y, byte curr_grid_state){
    //get the current state of the grid space 
    int new_grid_col = (curr_grid_state == 1) ? LColor.GREEN_HIGH : LColor.OFF;  //set the color to off if the state is 0        
    this.pad.changeGrid(x, y, new_grid_col);        //change the color;
    //println("Check cell " + x + " " + y + " state: " + this.curr_grid[x][y]);    
  }  

  void LightStep(int x, int prev_x){
    //takes the grid number, converts it to x,y coords, lights it   
    int ypos = (int)x / 8;  //divide by 8 (number of cells in a launchpad row), this will give the row number
    int xpos = x % 8; //get the xpos as the mod of the step with 8    
    //println("Cell " + xpos + " " + ypos + " state: " + this.curr_grid[xpos][ypos]);
    this.pad.changeGrid(xpos, ypos, STEP_ON);      
  }

  void LightStep(int x, int prev_x, boolean on_beat){
    //if the current step is on a beat, then use a different colour
    //takes the grid number, converts it to x,y coords, lights it   
    int ypos = (int)x / 8;  //divide by 8 (number of cells in a launchpad row), this will give the row number
    int xpos = x % 8; //get the xpos as the mod of the step with 8    
    int col = (on_beat) ? STEP_ON_BEAT : STEP_ON;
    //println("Cell " + xpos + " " + ypos + " state: " + this.curr_grid[xpos][ypos]);
    this.pad.changeGrid(xpos, ypos, col);      
  }
   
  void TransportButton(int button){
    //undergoes a certain action based on the transport button clicked
    switch(button) {   
      case LButton.MIXER:  
        //println("Return to sequencer scene");
        this.curr_scene = this.SEQ_SCENE; //resets the scene view if the mixer button is pressed
        this.pad.reset();  //resets all the LEDS
        break;   
      default:
        break;   
    }    
  }  

  void ChangeScene(int scene, byte[][] scene_state) {
    //reset the grid
    for (int i=0;i<8;i++){
      for (int j=0;j<8;j++){
        this.SetGrid(i,j,scene_state[i][j]);
      }      
    }
    this.pad.changeSceneButton(this.curr_scene+1, LColor.OFF);      //turn off the current scene light
    this.curr_scene = scene;                                        //set the new scene    
    this.pad.changeSceneButton(scene+1, LColor.GREEN_HIGH);         //turn on the new scene light    
  }   

  public int SceneNum(int scene) {
    int new_scene = -1;
    //query for a particular scene, the scene number is passed and the related index is returned
    switch(scene){   
      case LButton.SCENE1:
        new_scene = 0;
        break;   
      case LButton.SCENE2:
        new_scene = 1;
        break;   
      case LButton.SCENE3:
        new_scene = 2;
        break;   
      case LButton.SCENE4:
        new_scene = 3;
        break;   
      case LButton.SCENE5:
        new_scene = 4;
        break;  
      case LButton.SCENE6:
        new_scene = 5;
        break;   
      case LButton.SCENE7:
        new_scene = 6;
        break;  
      case LButton.SCENE8:
        new_scene = 7;
        break;            
      default:
        new_scene = SEQ_SCENE;
        break;
    }
    return new_scene;
  }

  public int CurrentScene() {
    //returns the current scene
    return this.curr_scene;
  }

  //Utility functions / testers
  public int StepX(int step){
    //takes a single value index of the current step, returns the x-grid position
    return step%8;
  }
  
  public int StepY(int step){
    //takes a single value index of the current step, returns the y-grid position
    return (int)step/8;
  }
  
  public void Flash(){
    this.curr_scene = this.SEQ_SCENE;   //default to the sequencer scene    
    this.pad.testLeds();  //test all the leds  
    this.pad.reset();     //reset all the leds 
  }
  public void Cleanup() {
    this.pad = null;
  }
}

