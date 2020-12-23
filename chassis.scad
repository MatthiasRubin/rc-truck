// this file shows the  assembled truck base

// used parts



// shows truck base
chassis();



module chassis()
{
  frame();
  
  translate([0,125,0]) axle();
  translate([0,-125,0]) axle();
  
  translate([50,-125,0]) wheel();
  translate([50,125,0]) wheel();
  translate([-50,-125,0]) rotate([0,180,0]) wheel();
  translate([-50,125,0]) rotate([0,180,0]) wheel();
}


module frame()
{
  translate([0,0,25]) cube([50,370,30], center = true);
  
}

module axle()
{
  rotate([0,90,0]) 
  {
    cylinder(d = 7, h = 120, center = true);
  
    translate([-5,0,0]) cube([10,20,50], center = true);
    
    difference()
    {
      cylinder(d = 20, h = 99, center = true);
      cylinder(d = 8, h = 120, center = true);
    }
  }
}

module wheel()
{
  rotate([0,90,0]) cylinder(d = 60,h = 20);
}