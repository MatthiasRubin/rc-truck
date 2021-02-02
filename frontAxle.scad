// this file defines the front axle


// used modules
use <copy.scad>
use <transform.scad>


// used parts
use <wheel.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// shows front axle
frontAxle();


// assembled front axle
module frontAxle()
{
  translateZ(-12.5)
  {
    // axle beam
    axleBeamTop();
    axleBeamBottom();
    
    // steering knuckles
    translateX(42.5) steeringKnuckle();
    translateX(-42.5) doubleSteeringKnuckle();
    
    rotateCopyY(180)
    {
      // shafts
      translateX(42) shaft();
      
      // wheels
      translateX(-70) wheel();
    }
    
    // steering rod
    translate([0,27,4.6]) steeringRod();
  }
}


// axle beam: top half
module axleBeamTop()
{
  difference()
  {
    union()
    {
      // basic beam
      cube([90,8,25], center = true);
      
      mirrorCopyX()
      {
        // roundings
        translateX(45) cylinder(d = 8, h = 25, center = true);
        
        // support to mound axle
        translateX(20) cube([10,15,25], center = true);
      }
    }
    
    mirrorCopyX()
    {
      translateX(45)
      {
        // remove material for steering knuckles
        cube([20,10,15.2], center = true);
      
        // holes for steering knuckles
        cylinder(d = 4.1, h = 30, center = true);
      }
      
      // holes for screws to mount axle
      translateX(20) cylinder(d = 4.1, h = 30, center = true);
    }
    
    // remove bottom half
    translateZ(-10) cube([100,20,20], center = true);
  }
}


// axle beam: bottom half
module axleBeamBottom()
{
  difference()
  {
    // rotated top beam
    rotateX(180) axleBeamTop();
    
    // remove unused material at the bottom
    translateZ(-11) cube([50.1,20,7], center = true);
    
    // holes for nuts
    mirrorCopyX() translate([20,0,-15]) cylinder(d = 8, h = 11, $fn = 6);
  }
}


// doubled steering knuckle
module doubleSteeringKnuckle()
{
  rotateZ(180) mirrorCopyY() steeringKnuckle();
}


// steering knuckle
module steeringKnuckle()
{
  difference()
  {
    union()
    {
      // shaft holder
      translateX(3.5) cube([7,15,15], center = true);
      
      // axle beam joint
      translateX(2.5) cylinder(d = 4, h = 24, center = true);
      
      // steering arm
      rotateZ(20) translate([5.9,17,0]) cube([6.5,25,5], center = true);
    }
    
    // hole for shaft
    rotateY(90) cylinder(d = 8, h = 15, center = true);
    
    // hole for steering track rod
    translate([-3.5,27,-3]) cylinder(d = 4.1, h = 6);
  }
}


// steering track rod
module steeringRod()
{
  // basic rod
  cube([78,7,4], center = true);
  
  mirrorCopyX()
  {
    translateX(39)
    {
      // roundings
      cylinder(d = 7, h = 4, center = true);

      // steering knuckle joints
      translateZ(-9) cylinder(d = 4, h = 9);
    }
  }
}


// shaft
module shaft()
{
  rotateY(90)
  {
    // basic shaft
    cylinder(d = 6, h = 13);
    
    // wheel stop
    cylinder(d = 7.7, h = 8);
  }
  
  // end stop
  rotateY(-90) cylinder(d = 12, h = 2);
}


