// this file defines the front wheel


// global definitions
$fa = 5;
$fs = 0.5;


// shows front wheel
frontWheel();


// front wheel
module frontWheel()
{
  difference()
  {
    union()
    {
      difference()
      {
        // basic wheel
        rotate([0,90,0]) cylinder(d = 60,h = 20);

        // shape rim
        translate([10,0,0]) rotate([0,90,0]) cylinder(d1 = 30, d2 = 50, h = 20);
      }
      
      // support to hold shaft
      rotate([0,90,0]) cylinder(d = 12,h = 15);
    }
  
    // hole for shaft
    rotate([0,90,0]) cylinder(d = 6,h = 20, center = true);
  }
}

