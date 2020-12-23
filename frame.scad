// this file defines the frame
$fa = 10;
$fs = 1;
// used parts



// shows truck base
frame();


// frame
module frame()
{
  difference()
  {
    translate([0,0,25]) cube([50,370,30], center = true);
    translate([0,0,15]) cube([30,380,30], center = true);
    translate([0,125,31]) cube([60,20,22], center = true);
    translate([0,-125,31]) cube([60,20,22], center = true);
    translate([0,0,19]) cube([60,210,22], center = true);
    translate([0,170,19]) cube([60,50,22], center = true);
    translate([0,-170,19]) cube([60,50,22], center = true);
    
    translate([20,-125,0]) cylinder(d = 4.1, h = 30);
    translate([-20,-125,0]) cylinder(d = 4.1, h = 30);
    translate([20,125,0]) cylinder(d = 4.1, h = 30);
    translate([-20,125,0]) cylinder(d = 4.1, h = 30);
  }
}
