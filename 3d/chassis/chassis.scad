// this file defines the assembled truck chassis


// used modules
use <../modules/transform.scad>


// used parts
use <frontSection/frontSection.scad>
use <rearSection/rearSection.scad>
use <frame/frame.scad>
use <driveShaft/driveShaft.scad>
 

// shows truck chassis
chassis();


// assembled truck chassis
module chassis()
{
  // front section
  translateY(-125) frontSection();
  
  // middle section
  frameOffset = (100-80)/4;
  translateY(frameOffset) middleSection();
  
  // rear section
  translateY(125) rearSection();
  
  // drive shaft
  shaftLength = [0,250,0] - getFrontSectionMotorShaftOffset() + getRearSectionShaftOffset();
  shaftOffset = (getFrontSectionMotorShaftOffset() + getRearSectionShaftOffset())/2;
  translate(shaftOffset) driveShaft(shaftLength);
}


// middle section
module middleSection()
{
  // frame 
  frameLength = 250-(100+80)/2;
  translateZ(55) frame(frameLength);
}













