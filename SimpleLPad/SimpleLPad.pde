import com.rngtng.launchpad.*;

//declare the variables to be used
SimpleLPadControl spad;

void setup(){
  //create a new launchpad object and pass to te simplelpadcontrol object
  Launchpad pad = new Launchpad(this);
  spad = new SimpleLPadControl(pad);
  pad = null;
}

void draw(){
}

void launchpadButtonPressed(int buttonCode){
}  

void launchpadSceneButtonPressed(int buttonCode){
  spad.ChangeScene(buttonCode);  //call the change scene function
}  

void launchpadGridPressed(int x, int y){  
  spad.ToggleGrid(x, y);  //call the change grid function  
} 

void exit(){
  //this intercepts the exit method to ensure our memory is cleaned up
  println("Clean up the memory");
  spad.CleanUp();
  spad = null;  
  super.exit();
}



