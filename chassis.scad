// this file defines the assembled truck chassis


// used parts
use <frame.scad>
use <motor.scad>
use <driveShaft.scad>
use <rearAxle.scad>
use <servo.scad>
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
  
  // steering servo
  translate([0,-160,20]) rotate([180,0,0]) servo();
  
  // drive shaft
  translate([0,43.9,-4.05]) driveShaft();
  
  // axles
  translate([0,125,0]) rearAxle();
  translate([0,-125,0]) frontAxle();
}