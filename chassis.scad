// this file defines the assembled truck chassis


// used modules
use <transform.scad>


// used parts
use <frame.scad>
use <motor.scad>
use <steering.scad>
use <driveShaft.scad>
use <rearAxle.scad>
use <frontAxle.scad>


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
  
  // axles
  translateY(125) rearAxle();
  translateY(-125) frontAxle();
}