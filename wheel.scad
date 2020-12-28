// this file defines the wheel
$fa = 5;
$fs = 0.5;


// used parts



// shows wheel
wheel();


// wheel
module wheel()
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
      
      // add support to hold shaft
      rotate([0,90,0]) cylinder(d = 12,h = 15);
    }
  
    // add hole for shaft
    rotate([0,90,0]) cylinder(d = 7.1,h = 20, center = true);
  }
}

