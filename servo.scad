// this file defines the steering servo


// used modules
use <copy.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// shows steering servo
servo();


// steering servo
module servo()
{
  difference()
  {
    union()
    {
      // servo housing
      translate([0,0,-7]) cube([12,29.5,26], center = true);
      
      // servo mount
      translate([0,0,1]) cube([12,40,2], center = true);
       
      translate([0,5,0]) 
      {
        // servo shaft housing
        cylinder(d = 13, h = 10);
        
        // servo shaft
        cylinder(d = 5.5, h = 13.5);
      }
      
      // gear housing
      translate([0,-2,0]) cylinder(d = 9, h = 10);
    }
    
    // remove material from shaft housing
    mirrorCopy([1,0,0]) translate([6,0,-1]) cube([10,10,12]);
    
    // hole in servo shaft
    translate([0,5,10]) cylinder(d = 2, h = 10);
    
    // holes to mount servo
    mirrorCopy([0,1,0]) translate([0,18,-1]) cylinder(d = 5, h = 4);
  }
}

