//Simple class for controlling the LaunchPad
//provides basic functionality
import processing.core.PApplet;
import com.rngtng.launchpad.*;

class SimpleLPadControl {
  private int curr_scene, scenes = 8, grids = 64;
  private byte[][] grid_state;
  private LaunchPad pad;  
  private final byte GRID_OFF=0, GRID_ON=1;
  private final int BUTTON_OFF = LColor.OFF, BUTTON_ON = LColor.GREEN_HIGH, SCENE_ON = LColor.YELLOW_HIGH;  
  
  SimpleLPadControl(LaunchPad pad){
    this.pad = pad;
    this.pad.testLeds();  //test all the leds  
    this.pad.reset();     //reset all the leds     
    this.init();
  }
  
  public void ToggleGrid(int x, int y){
    //toggle the state of the grid cell
    int index = this.GridIndex(x, y);
    byte new_state = (this.grid_state[this.scene][index] == 0) ? GRID_ON : GRID_OFF;
    int new_col = (new_state == GRID_ON) ? BUTTON_ON : BUTTON_OFF;  //get the new colour for the grid
    this.grid_state[this.scene][index] = new_state;  //set the new state of the cell
    this.changeGrid(x, y, new_col);  //change the colour of the grid
  }  
  
  public void ChangeScene(int scene){
    //set the new scene of the 
    this.curr_scene = scene;
    //set the current scene colour to off
    //set the colour of the new scene button
  }
  
  //simple setters
  
  //simple getters
  public int GridIndex(int x, int y){return 8*y+x;}  //calculate the single grid index for the xy coords passed in
  
  //private memeber functions / utils
  private void init(){
    //initialize the data within the class
    this.ChangeScene(0);  //set the current scene to the initial scene
    grid_state = new byte[this.scenes][this.grids];
    //initialize the grid spaces to OFF
    for (int i=0;i<this.scenes;i++){
      for (int j=0;j<this.grids;j++){
        grid_state[i][j] = GRID_OFF;
      }
    }
  }
}
