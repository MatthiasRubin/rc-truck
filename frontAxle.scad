// this file defines the front axle
$fa = 5;
$fs = 0.5;


// used modules
use <copy.scad>


// used parts
use <wheel.scad>


// shows front axle
frontAxle();


// front axle
module frontAxle()
{
  translate([0,0,-12.5])
  {
    // add axle beam
    axleBeamTop();
    axleBeamBottom();
    
    rotateCopy([0,180,0]) 
    {
      // add steering knuckle
      translate([42.5,0,0]) steeringKnuckle();
      
      // add shaft
      translate([42,0,0]) shaft();
      
      // add wheel
      translate([50,0,0]) wheel();
    }
    
    // add steering rod
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
      
      // add roundings
      mirrorCopy([1,0,0]) translate([45,0,0]) cylinder(d = 8, h = 25, center = true);
      
      // add support to mound axle
      mirrorCopy([1,0,0]) translate([20,0,0]) cube([10,15,25], center = true);
    }
    
    // remove material for steering knuckles
    mirrorCopy([1,0,0]) translate([45,0,0]) cube([20,10,15.2], center = true);
    
    // add holes for steering knuckles
    mirrorCopy([1,0,0]) translate([45,0,0]) cylinder(d = 4.1, h = 30, center = true);
    
    // add holes for screws to mount axle
    mirrorCopy([1,0,0]) translate([20,0,0]) cylinder(d = 4.1, h = 30, center = true);
    
    // remove bottom half
    translate([0,0,-10]) cube([100,20,20], center = true);
  }
}


// axle beam: bottom half
module axleBeamBottom()
{
  difference()
  {
    // rotated top beam
    rotate([180,0,0]) axleBeamTop();
    
    // remove unused material at the bottom
    translate([0,0,-11]) cube([50.1,20,7], center = true);
    
    // add holes for nuts
    mirrorCopy([1,0,0]) translate([20,0,-15]) cylinder(d = 8, h = 11, $fn = 6);
  }
}


// steering knuckle
module steeringKnuckle()
{
  difference()
  {
    union()
    {
      // shaft holder
      translate([3.5,0,0]) cube([7,15,15], center = true);
      
      // add axle beam joint
      translate([2.5,0,0]) cylinder(d = 4, h = 24, center = true);
      
      // add steering arm
      rotate([0,0,20]) translate([5.9,17,0]) cube([6.5,25,5], center = true);
    }
    
    // add hole for shaft
    rotate([0,90,0]) cylinder(d = 8, h = 15, center = true);
    
    // add hole for steering track rod
    translate([-3.5,27,-3]) cylinder(d = 4.1, h = 6);
  }
}


// steering track rod
module steeringRod()
{
  // basic rod
  cube([78,7,4], center = true);
  
  // add roundings
  mirrorCopy([1,0,0]) translate([39,0,0]) cylinder(d = 7, h = 4, center = true);

  // add steering knuckle joints
  mirrorCopy([1,0,0]) translate([39,0,-9]) cylinder(d = 4, h = 9);
}


// shaft
module shaft()
{
  // basic shaft
  rotate([0,90,0]) cylinder(d = 6, h = 13);
  
  // add wheel stop
  rotate([0,90,0]) cylinder(d = 7.7, h = 8);
  
  // add end stop
  rotate([0,-90,0]) cylinder(d = 12, h = 2);
}


