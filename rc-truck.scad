// this file shows the fully assembled truck

// used parts



// shows truck
truck();


// this module is the fully assembled truck
module truck()
{
  frame();
  
  translate([0,125,0]) axle();
  translate([0,-125,0]) axle();
  
  translate([50,-125,0]) wheel();
  translate([50,125,0]) wheel();
  translate([-50,-125,0]) rotate([0,180,0]) wheel();
  translate([-50,125,0]) rotate([0,180,0]) wheel();
  
  translate([0,-200,35]) cabin();
  translate([0,80,110]) box();
}

module box()
{
  cube([150,340,150], center = true);
}

module cabin()
{
  translate([0,50,50]) cube([150,100,100], center = true);
  translate([0,15,-15]) cube([150,30,30], center = true);
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