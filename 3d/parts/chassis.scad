// this file defines the assembled truck chassis


// used modules
use <../modules/transform.scad>


// used parts
use <frame.scad>
use <motor.scad>
use <steering.scad>
use <driveShaft.scad>
use <rearAxle/rearAxle.scad>
use <frontAxle/frontAxle.scad>


// shows truck chassis
chassis();


// assembled truck chassis
module chassis()
{
  // frame 
  frame();
  
  // motor
  translate([0,-38,25]) motor();
  
  // steering
  translateY(-125) steering();
  
  // drive shaft
  translate([0,43.9,-4.05]) driveShaft();
  
  // battery
  //translate([0,-115,70]) rotateX(90) cube([50,56,29], center = true);
  
  // axles
  translateY(125) rearAxle();
  translateY(-125) frontAxle();
}