// this file defines the axle
$fa = 10;
$fs = 0.5;


// used parts
use <wheel.scad>


// shows axle
axle();


// axle
module axle()
{
  translate([0,0,-12.5])
  {
    // add housing
    housingTop();
    housingBottom();
  
    // add shaft
    shaft();
  
    // add wheels
    translate([50,0,0]) wheel();
    translate([-50,0,0]) rotate([0,180,0]) wheel();
  }
}


// axle housing top
module housingTop()
{
  difference()
  {
    union()
    {
      // basic axle
      rotate([0,90,0]) cylinder(d = 20, h = 99, center = true);
      
      // add support to mount axle
      translate([20,0,0]) cube([10,18,25], center = true);
      translate([-20,0,0]) cube([10,18,25], center = true);
      
      // add support to mount bottom
      translate([30,8,0]) cylinder(d = 8, h = 9.001, center = true);
      translate([-30,8,0]) cylinder(d = 8, h = 9.001, center = true);
      translate([30,-8,0]) cylinder(d = 8, h = 9.001, center = true);
      translate([-30,-8,0]) cylinder(d = 8, h = 9.001, center = true);
    }
    
    // add hole for shaft
    rotate([0,90,0]) cylinder(d = 8, h = 100, center = true);
    
    // add holes for screws to mount bottom
    translate([30,8,0]) cylinder(d = 4.1, h = 30, center = true);
    translate([-30,8,0]) cylinder(d = 4.1, h = 30, center = true);
    translate([30,-8,0]) cylinder(d = 4.1, h = 30, center = true);
    translate([-30,-8,0]) cylinder(d = 4.1, h = 30, center = true);
    
    // add holes for screw heads
    translate([30,8,4.5]) cylinder(d = 7.5, h = 5);
    translate([-30,8,4.5]) cylinder(d = 7.5, h = 5);
    translate([30,-8,4.5]) cylinder(d = 7.5, h = 5);
    translate([-30,-8,4.5]) cylinder(d = 7.5, h = 5);
    
    // add holes for screws to mount axle
    translate([20,0,0]) cylinder(d = 4.1, h = 15);
    translate([-20,0,0]) cylinder(d = 4.1, h = 15);
    
    // add holes for nuts
    translate([20,0,0]) cylinder(d = 8, h = 8, $fn = 6);
    translate([-20,0,0]) cylinder(d = 8, h = 8, $fn = 6);
    
    // remove top half
    translate([0,0,-8]) cube([100,26,16], center = true);
  }
}


// axle housing bottom
module housingBottom()
{
  difference()
  {
    union()
    {
      // basic axle
      rotate([0,90,0]) cylinder(d = 20, h = 99, center = true);
      
      // add support to mount top
      translate([30,8,0]) cylinder(d = 8, h = 9.001, center = true);
      translate([-30,8,0]) cylinder(d = 8, h = 9.001, center = true);
      translate([30,-8,0]) cylinder(d = 8, h = 9.001, center = true);
      translate([-30,-8,0]) cylinder(d = 8, h = 9.001, center = true);
    }
    
    // add hole for shaft
    rotate([0,90,0]) cylinder(d = 8, h = 100, center = true);
    
    // add holes for screws to mount top
    translate([30,8,0]) cylinder(d = 4.1, h = 20, center = true);
    translate([-30,8,0]) cylinder(d = 4.1, h = 20, center = true);
    translate([30,-8,0]) cylinder(d = 4.1, h = 20, center = true);
    translate([-30,-8,0]) cylinder(d = 4.1, h = 20, center = true);
    
    // add holes for nuts
    translate([30,8,-8]) cylinder(d = 8, h = 3.5, $fn = 6);
    translate([-30,8,-8]) cylinder(d = 8, h = 3.5, $fn = 6);
    translate([30,-8,-8]) cylinder(d = 8, h = 3.5, $fn = 6);
    translate([-30,-8,-8]) cylinder(d = 8, h = 3.5, $fn = 6);
    
    // remove top half
    translate([0,0,6]) cube([100,26,12], center = true);
  }
}


// shaft
module shaft()
{
  rotate([0,90,0]) cylinder(d = 7, h = 120, center = true);
}


