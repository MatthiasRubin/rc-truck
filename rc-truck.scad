// this file defines the fully assembled truck

// used parts
use <chassis.scad>


// shows truck
truck();


// fully assembled truck
module truck()
{
  // add chassis
  chassis();
  
  // add cabin in front
  translate([0,-200,35]) cabin();
  
  // add cargo box in the back
  translate([0,80,110]) cargoBox();
}


// cargo box
module cargoBox()
{
  cube([150,340,150], center = true);
}


// driver cabin
module cabin()
{
  translate([0,50,50]) cube([150,100,100], center = true);
  translate([0,15,-15]) cube([150,30,30], center = true);
}

