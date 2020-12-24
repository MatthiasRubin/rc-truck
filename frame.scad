// this file defines the frame
$fa = 10;
$fs = 1;
// used parts



// shows truck base
frame();


// frame
module frame()
{
  frameHalf();
  rotate([0,0,180]) frameHalf();
}

module frameHalf()
{
  difference()
  {
    translate([0,92.5,25]) cube([50,185,30], center = true);
    translate([0,95,15]) cube([30,195,30], center = true);
    
    translate([0,125,31]) cube([60,20,22], center = true);
    translate([0,52,19]) cube([60,106,22], center = true);
    translate([0,170,19]) cube([60,50,22], center = true);
    
    translate([0,57.5,35]) cube([30,95,15], center = true);
    translate([0,160,35]) cube([30,30,15], center = true);
    
    translate([20,125,0]) cylinder(d = 4.1, h = 30);
    translate([-20,125,0]) cylinder(d = 4.1, h = 30);
    
    translate([10,5,35]) rotate([90,0,0]) cylinder(d = 4.1, h = 15, center = true);
    translate([-10,5,35]) rotate([90,0,0]) cylinder(d = 4.1, h = 15, center = true);
  } 
}

