// this file defines the steering mechanism


// used modules
use <../../modules/copy.scad>
use <../../modules/transform.scad>


// used parts
use <servo.scad>
use <frontAxle/frontAxle.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// shows assembled steering mechanism
steering();


// assembled steering mechanism
module steering()
{
  // steering servo
  translate([0,-35,20]) rotateX(180) servo();
  
  // servo arm
  servoArm();
  
  // steering arm
  steeringArm();
}


// servo arm
module servoArm()
{
  translate([0,-30,7.3]) difference()
  {
    union()
    {
      // basic arm
      translateY(-1.5) cube([10,17,5], center = true);
    
      // roundings
      translateY(-10) cylinder(d = 10, h = 5, center = true);
      translate([0,7,-3]) cylinder(d = 10, h = 11, center = true);
      
      // steering arm joint
      translate([0,10,-16.5]) cylinder(d = 4, h = 9.5);
    }
    
    translateY(-10) 
    {
      // hole for servo shaft
      translateZ(-1) cylinder(d = 6.2, h = 4);
      
      // hole for screw
      cylinder(d = 3, h = 6, center = true);
    }
  }
}


// steering arm
module steeringArm()
{
  translate([0,-20,-6]) difference()
  {
    rotateZ(10.2) translateX(-19.8) 
    {
      // basic arm
      cube([39.6,8,4], center = true);
      
      // roundings
      mirrorCopyX() translateX(19.8) cylinder(d = 8, h = 4, center = true);
      
      // steering knuckle joint
      translate([-19.8,0,-9]) cylinder(d = 3.5, h = 9);
    }
    
    // hole for servo arm
    cylinder(d = 5, h = 5, center = true);
  }
}


