public interface SequenceProcessor {
  //this is an abstract interface for the seqence processor
  //the idea is to provide a generic interface so any type of processor can be created and integrated with the modularsequencer class
  void SetStep(int step, int state);  //this adds a new step number to the list of steps to be processed
  void ProcessStep(int current_step); //takes the current step and processes any actions that are assigned to that step, called each loop
}
