/* This class contains the functionality for the sequencer functions
*  this sets up the step sequencer and controls the timing 
*/

//60Bpm = 1bps = 1fps
//140bpm = 140/60 = 2.3bps = 2.3fps
//the draw function gets called based on the frameRate, therefore, set the frameRate to the bps rate

class ModularSequencer {
  private int steps = 16, current_step=-1;  //steps is the max number of steps allowed (16 by default)
  private int bpm = 140, curr_sequence = -1; 
  private float frame_rate = 0;
  private byte[][][] sequence;
  private final int num_seqs = 8, steps_in_seq = 64, x_steps = 8, y_steps = 8;
  
  public ModularSequencer(){this.init(this.bpm, this.steps);}
  public ModularSequencer(int bpm){this.init(bpm, this.steps);}
  public ModularSequencer(int bpm, int steps){this.init(bpm, steps);}    
  private void init(int bpm, int steps){
    this.bpm = bpm;
    this.steps = steps;
    this.frame_rate = (float)bpm/60.0; //convert the bpm's to bps, use this as the framerate for the sketch
    this.sequence = new byte[this.num_seqs][this.x_steps][this.y_steps]; 
    for (int i=0;i<this.num_seqs;i++)
     this.sequence[i] = new byte[this.x_steps][this.x_steps]; 
  }
  
  public void LoadSequence(int sequence){
    this.curr_sequence = sequence;
  }
  
  public int NextStep(){
    //if the current step is less than the max then incrememnt, otherwise reset to 0
    this.current_step = (this.current_step < this.steps-1) ? this.current_step + 1 : 0;
    return this.current_step;
  }
  
  public void ToggleStep(int seq_num, int x, int y){
    //if the current state of the space is 0, then set to 1 otherwise set to 0;
    int new_state = (sequence[seq_num][x][y] == 0) ? 1 : 0;    
    this.sequence[seq_num][x][y] = (byte)new_state;    
    //println("Set pos " + x + " " + y + " for seq: " + seq_num + " to val: " + new_state); 
  }
  
  public byte StepState(int x, int y){
    if (this.curr_sequence >= 0){
      //println("Step " + x + " " + y + " for seq: " + this.curr_sequence + " has val " + this.sequence[this.curr_sequence][x][y]);      
      return this.sequence[this.curr_sequence][x][y];
    }
    return 0;
  }
  
  //resets a specifc sequence
  public void ClearSequence(int seq_num){
    this.sequence[seq_num] = new byte[this.x_steps][this.y_steps];
  }
  
  //resets all sequences
  public void ClearAllSequences(){
    this.sequence = new byte[this.num_seqs][this.x_steps][this.y_steps];
  }
  
  //useful methods to have
  //this function turns off a specific step in a specific sequence  
  private void ClearStep(int seq_num, int x, int y){this.sequence[seq_num][x][y] = 0;}    
  //this function turns on a specific step in a specific sequence  
  private void AddStep(int seq_num, int x, int y){this.sequence[seq_num][x][y] = 1;}    
   
  //simple getters
  int CurrentSequence(){return this.curr_sequence;}
  byte[][] Sequence(int num){return this.sequence[num];}
  int CurrentStep(){return this.current_step;}
  float SeqFrameRate(){return this.frame_rate;}
  
  public void Cleanup(){
    this.sequence = null;
  }
}
