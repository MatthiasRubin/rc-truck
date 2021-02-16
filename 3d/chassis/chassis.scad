// this file defines the assembled truck chassis


// used modules
use <../modules/transform.scad>


// used parts
use <frontSection/frontSection.scad>
use <rearSection/rearSection.scad>
use <frame/frame.scad>
use <driveShaft.scad>
 

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
  
  // battery
  //translate([0,-110,110]) cube([56,29,50], center = true);
}


// middle section
module middleSection()
{
  // frame 
  frameLength = 250-(100+80)/2;
  translateZ(55) frame(frameLength);
}













