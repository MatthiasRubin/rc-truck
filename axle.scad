// this file defines the axle

// used parts
use <wheel.scad>


// shows axle
axle();


// axle
module axle()
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


// axle housing top
module housingTop()
{
  
  difference()
  {
    union()
    {
      rotate([0,90,0]) cylinder(d = 20, h = 99, center = true);
      translate([0,0,5]) cube([50,20,10], center = true);
    }
    
    rotate([0,90,0]) cylinder(d = 8, h = 100, center = true);
    
    translate([0,0,-6]) cube([100,21,12], center = true);
  }
}


// axle housing bottom
module housingBottom()
{
  difference()
  {
    rotate([0,90,0]) cylinder(d = 20, h = 99, center = true);
    rotate([0,90,0]) cylinder(d = 8, h = 100, center = true);
    
    translate([0,0,6]) cube([100,21,12], center = true);
  }
}


// shaft
module shaft()
{
  rotate([0,90,0]) cylinder(d = 7, h = 120, center = true);
}


