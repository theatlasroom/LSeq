import com.rngtng.launchpad.*;
import themidibus.*;

class LPadControl {
  //interface for basic control of the launchpad
  private Launchpad pad;
  //a list of consts for each of the possible scene states and the current scene pointer
  private int curr_scene; 
  private final int SEQ_SCENE = -1;
  private int BUTTON_OFF = LColor.OFF, SCENE_ON = LColor.YELLOW_HIGH, STEP_ON = LColor.YELLOW_HIGH, STEP_ON_BEAT = LColor.RED_HIGH;
  private byte[][] curr_grid;
  public LPadControl(Launchpad pad) {
    this.pad = pad;
    this.pad.flashingAuto();  
    this.Flash(); 
  }
  
  void ToggleGrid(int x, int y){
    //get the current state of the grid space 
    int new_grid_state = (this.curr_grid[x][y] == 0) ? 1 : 0;  //set the state to 1 if it is 0, otherwise set to 0
    int new_grid_col = (new_grid_state == 0) ? LColor.OFF : LColor.GREEN_HIGH;  //set the color to off if the state is 0
    this.curr_grid[x][y] = (byte)new_grid_state;    //store the new state
    this.pad.changeGrid(x, y, new_grid_col);        //change the color;
  }  

  void LightStep(int x, int prev_x, boolean on_beat) {
    //println("x: " + x + " prev_x: " + (x-1));
    //takes the grid number, converts it to x,y coords, lights it   
    int ypos = (int)x / 8;  //divide by 8 (number of cells in a launchpad row), this will give the row number
    int xpos = x % 8; //get the xpos as the mod of the step with 8    
    //println("Pos: " + xpos + " " + ypos);
    int col = (on_beat) ? STEP_ON_BEAT : STEP_ON;     
    this.pad.changeGrid(xpos, ypos, col);
    this.LightStepOff(prev_x);
  }

  void LightStepOff(int xpos) {
    //takes the grid number, converts it to x,y coords, lights it   
    int ypos = (int)xpos / 8;  //divide by 8 (number of cells in a launchpad row), this will give the row number
    xpos = xpos % 8; //get the xpos as the mod of the step with 8
    this.pad.changeGrid(xpos, ypos, BUTTON_OFF);
  }
  
   
  void TransportButton(int button){
    //undergoes a certain action based on the transport button clicked
    switch(button) {   
      case LButton.MIXER:  
        println("Return to sequencer scene");
        this.curr_scene = this.SEQ_SCENE; //resets the scene view if the mixer button is pressed
        this.pad.reset();  //resets all the LEDS
        break;   
      default:
        break;   
    }    
  }  

  void ChangeScene(int scene, byte[][] scene_state) {
    println("New scene: " + scene);
    println(Arrays.toString(scene_state));
    //buttonCode, LColor.RED_HIGH
    this.curr_scene = scene;
    this.curr_grid = scene_state;
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
  public void Flash(){
    this.curr_scene = this.SEQ_SCENE;   //default to the sequencer scene
    this.curr_grid = new byte[8][8];    //setup a default 8x8 grid for the pad    
    //this function turns all LEDS on then off straight away
    this.pad.testLeds();  //test all the leds  
    this.pad.reset();     //reset all the leds 
  }
  public void Cleanup() {
    this.pad = null;
  }
}

