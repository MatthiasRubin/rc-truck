// this file defines the front axle
$fa = 5;
$fs = 0.5;


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
    
    // add steering knuckles
    translate([42.5,0,0]) steeringKnuckle();
    translate([-42.5,0,0]) mirror([1,0,0]) steeringKnuckle();
    
    // add steering rod
    translate([0,27,4.6]) steeringRod();
    
    // add shafts
    translate([42,0,0]) shaft();
    translate([-42,0,0]) rotate([0,180,0]) shaft();
  
    // add wheels
    translate([50,0,0]) wheel();
    translate([-50,0,0]) rotate([0,180,0]) wheel();
  }
}


module axleBeamTop()
{
  difference()
  {
    union()
    {
      cube([90,8,25], center = true);
      translate([45,0,0]) cylinder(d = 8, h = 25, center = true);
      translate([-45,0,0]) cylinder(d = 8, h = 25, center = true);
      
      translate([20,0,0]) cube([10,15,25], center = true);
      translate([-20,0,0]) cube([10,15,25], center = true);
    }
    
    translate([45,0,0]) cube([20,10,15.2], center = true);
    translate([-45,0,0]) cube([20,10,15.2], center = true);
    
    translate([45,0,0]) cylinder(d = 4.1, h = 30, center = true);
    translate([-45,0,0]) cylinder(d = 4.1, h = 30, center = true);
    
    translate([20,0,0]) cylinder(d = 4.1, h = 30, center = true);
    translate([-20,0,0]) cylinder(d = 4.1, h = 30, center = true);
    
    translate([0,0,-10]) cube([100,20,20], center = true);
  }
}


module axleBeamBottom()
{
  difference()
  {
    union()
    {
      cube([90,8,25], center = true);
      translate([45,0,0]) cylinder(d = 8, h = 25, center = true);
      translate([-45,0,0]) cylinder(d = 8, h = 25, center = true);
      
      translate([20,0,0]) cube([10,15,25], center = true);
      translate([-20,0,0]) cube([10,15,25], center = true);
    }
    
    translate([45,0,0]) cube([20,10,15.2], center = true);
    translate([-45,0,0]) cube([20,10,15.2], center = true);
    
    translate([0,0,-11]) cube([50.1,20,7], center = true);
    
    translate([45,0,0]) cylinder(d = 4.1, h = 30, center = true);
    translate([-45,0,0]) cylinder(d = 4.1, h = 30, center = true);
    
    translate([20,0,0]) cylinder(d = 4.1, h = 30, center = true);
    translate([-20,0,0]) cylinder(d = 4.1, h = 30, center = true);
    
    translate([20,0,-15]) cylinder(d = 8, h = 11, $fn = 6);
    translate([-20,0,-15]) cylinder(d = 8, h = 11, $fn = 6);
    
    translate([0,0,10]) cube([100,20,20], center = true);
  }
}


// 
module steeringKnuckle()
{
  difference()
  {
    union()
    {
      translate([3.5,0,0]) cube([7,15,15], center = true);
      translate([2.5,0,0]) cylinder(d = 4, h = 24, center = true);
      rotate([0,0,20]) translate([5.9,17,0]) cube([6.5,25,5], center = true);
    }
    
    rotate([0,90,0]) cylinder(d = 8, h = 15, center = true);
    translate([-3.5,27,-3]) cylinder(d = 4.1, h = 6);
  }
}


// 
module steeringRod()
{
  cube([78,7,4], center = true);
  translate([39,0,0]) cylinder(d = 7, h = 4, center = true);
  translate([-39,0,0]) cylinder(d = 7, h = 4, center = true);

  translate([39,0,-9]) cylinder(d = 4, h = 9);
  translate([-39,0,-9]) cylinder(d = 4, h = 9);
}


// shaft
module shaft()
{
  rotate([0,90,0]) cylinder(d = 7, h = 18);
  rotate([0,-90,0]) cylinder(d = 12, h = 2);
}


