// this file defines the motor


// used modules
use <copy.scad>
use <transform.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// shows motor
motor();


// assembled motor
module motor()
{
  // motor dummy
  translateZ(-31.8) motorDummy();
  
  // motor mount
  rotateCopyZ(180) motorMount();
}


// motor mount
module motorMount()
{
  translateY(15.5) difference()
  {
    // basic motor mount
    cube([30,12,10], center = true);
    
    // shape motor mount
    translateY(3.5) cube([24,10,11], center = true);
    
    // holes to attach motor mount to frame
    translateY(2.5) rotateY(90) cylinder(d = 3.2, h = 35, center = true);
    
    // holes to attach motor
    mirrorCopyX() translate([17.5/2,-2.7,0]) rotateX(90) cylinder(d = 6, h = 10);
  }
}


// motor dummy
module motorDummy()
{
  difference()
  {
    union()
    {
      // motor
      difference()
      {
        translateZ(20) cylinder(d = 22.5, h = 44.2);
        mirrorCopyY() translate([0,34,42]) cube(50, center = true);
      }
      
      // gear box
      translateZ(18.5) cube([22.5,18.8,37], center = true);
      
      // basic motor shaft
      translateZ(11.2) rotateX(90) cylinder(d = 7.2, h = 37.6, center = true);
    }
    
    // holes to mount motor
    mirrorCopyX() translate([17.5/2,0,31.8]) rotateX(90) 
      cylinder(d = 3, h = 20, center = true);
    
    // shaft phase
    mirrorCopyY() translateY(15.7)
    {
      translateZ(4.9) cube(10, center = true);
      translateZ(18.5) cube(10, center = true);
    }
    
  }
}

