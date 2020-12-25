// this file defines the axle

// used parts
use <wheel.scad>


// shows axle
axle();


// axle
module axle()
{
  // add housing
  housing();
  
  // add shaft
  shaft();
  
  // add wheels
  translate([50,0,0]) wheel();
  translate([-50,0,0]) rotate([0,180,0]) wheel();
  
}


// axle housing
module housing()
{
  rotate([0,90,0]) 
  {
    translate([-5,0,0]) cube([10,20,50], center = true);
    
    difference()
    {
      cylinder(d = 20, h = 99, center = true);
      cylinder(d = 8, h = 120, center = true);
    }
  }
}


// shaft
module shaft()
{
  rotate([0,90,0]) cylinder(d = 7, h = 120, center = true);
}


