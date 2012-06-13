import com.rngtng.launchpad.*;
/*
* This sketch is for a basic modular sequencer, 
* the sequencer only sets up the paramters and the basic actions for each track and can be connected to audio / video whatever
* the output of the sequencer can be completely reprogrammed for any use (audio, video sequencing, mixture, process effcts etc)
*/
int SEQUENCE_START_ROW = 0;

ModularSequencer ms;
LPadControl pad;
int step=0, prev_step=-1, pad_color;
boolean step_on_beat;

void setup(){
  ms = new ModularSequencer(120, 16);  //create a new sequencer object, with bpm 144 and 64 steps
  Launchpad new_pad = new Launchpad(this);  
  pad = new LPadControl(new_pad);     //create a new pad object
  println("Frame rate: " + ms.SeqFrameRate());
  frameRate(ms.SeqFrameRate()); 
}

void draw(){
  //generate the next step in the sequence
  step = ms.NextStep();
  step_on_beat = (step%4==0) ? true : false; //set the step on beat flag based on the beat division (in this case 4)
  //light up the next step on the sequencer
  pad.LightStep(step, prev_step, step_on_beat);
  prev_step = step;
}

void Process(int step){
  //run through all the scenes and trigger any that have a light for this step in the sequence
  //process the events that should occur at this particular step
}

void launchpadButtonPressed(int buttonCode){
  println(buttonCode);
  pad.TransportButton(buttonCode);  
}  

void launchpadSceneButtonPressed(int buttonCode){
  println(buttonCode);
  int sc = pad.SceneNum(buttonCode);
  pad.ChangeScene(sc, ms.Sequence(sc));  
  //println("Scene Button pressed: " + buttonCode);
  ////lpad.changeSceneButton(buttonCode, LColor.RED_HIGH);
}  

void launchpadSceneButtonReleased(int buttonCode){
  //pad.ChangeScene(buttonCode);  
  //println("Scene Button pressed: " + buttonCode);
  //lpad.changeSceneButton(buttonCode, LColor.GREEN_HIGH + LColor.FLASHING);
}  

void launchpadGridPressed(int x, int y){
  int scene = pad.CurrentScene();
  //println("curr scene: " + scene);
  //process the keypress event for a grid space
  if (scene != pad.SEQ_SCENE){
    pad.ToggleGrid(x, y);
    ms.ToggleStep(scene, x, y);
  }
} 

void exit(){
  //this intercepts the exit method to ensure our memory is cleaned up
  println("Clean up the memory");
  ms.Cleanup();
  pad.Cleanup();
  pad = null;
  ms = null;
  super.exit();
}
