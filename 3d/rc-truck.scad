// this file defines the fully assembled truck


// used parts
use <chassis/chassis.scad>


// shows truck
truck();


// fully assembled truck
module truck()
{
  // chassis
  chassis();
  
  // cabin in front
  translate([0,-205,60]) %cabin();
  
  // cargo box in the back
  translate([0,90,145]) %cargoBox();
}


// cargo box
module cargoBox()
{
  cube([140,330,165], center = true);
}


// driver cabin
module cabin()
{
  translate([0,57.5,60]) cube([140,115,120], center = true);
  translate([0,20,-20]) cube([140,40,40], center = true);
}

