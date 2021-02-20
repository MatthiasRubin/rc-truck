// this file defines the fully assembled truck


// used modules
use <modules/transform.scad>


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
  translate([0,-190,65]) %cabin();
  
  // cargo box in the back
  translate([0,80,135]) %cargoBox();
}


// cargo box
module cargoBox()
{
  cube([130,350,140], true);
}


// driver cabin
module cabin()
{
  difference()
  {
    translate([0,45,45]) cube([125,90,90], true);
    translate([-65,0,35]) rotateX(75) cube([130,90,90]);
  }
  translate([0,15,-18]) cube([125,30,36], true);
}

