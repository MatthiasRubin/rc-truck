// this file defines the assembled truck chassis


// used parts
use <frame.scad>
use <motor.scad>
use <rearAxle.scad>
use <frontAxle.scad>


// shows truck chassis
chassis();


// assembled truck chassis
module chassis()
{
  // add frame
  frame();
  
  // motor
  translate([0,-35,25]) motor();
  
  // add axles
  translate([0,125,0]) rearAxle();
  translate([0,-125,0]) frontAxle();
}