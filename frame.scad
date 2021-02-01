// this file defines the truck frame


// used modules
use <copy.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// shows truck frame
frame();


// assembled truck frame
module frame()
{
  // put two halfs together
  rotateCopy([0,0,180]) frameHalf();
}


// truck frame half
module frameHalf()
{
  difference()
  {
    // basic frame
    translate([0,92.5,15]) cube([50,185,30], center = true);
    
    // remove unused inside
    translate([0,95,5]) cube([30,195,30], center = true);
    
    // shape frame
    translate([0,125,21]) cube([60,20,22], center = true);
    translate([0,52,9]) cube([60,106,22], center = true);
    translate([0,170,9]) cube([60,50,22], center = true);
    
    // remove unused material on shaped frame
    translate([0,57.5,25]) cube([30,95,15], center = true);
    translate([0,160,25]) cube([30,30,15], center = true);
    
    mirrorCopy([1,0,0])
    {
      // holes to mount axles
      translate([20,125,-5]) cylinder(d = 4.1, h = 30);
    
      // holes to put halfs together
      translate([10,5,25]) rotate([90,0,0]) cylinder(d = 4.1, h = 15, center = true);
    }
    
    // holes to mount servo
    translateCopy([0,36,0]) translate([0,142,25]) cylinder(d = 4.1, h = 11, center = true);
    
    // holes to mount motor
    translateCopy([0,36,0]) translate([0,20,25]) rotate([0,90,0]) 
      cylinder(d = 3.2, h = 51, center = true);
  } 
}