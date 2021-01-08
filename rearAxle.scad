// this file defines the rear axle


// used modules
use <copy.scad>
use <gears.scad>


// used parts
use <wheel.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions
inputGearAngle = getConeAngle(15, 30);
outputGearAngle = getConeAngle(30, 15);
inputGearOffset = getBevelGearOffset(15, inputGearAngle, 0.7);
outputGearOffset = getBevelGearOffset(30, outputGearAngle, 0.7);


// shows rear axle
rearAxle();


// rear axle
module rearAxle()
{
  translate([0,0,-12.5])
  {
    // add housing
    //housingTop();
    //housingBottom();
    
    // add shaft
    leftShaft();
    rotate([45,0,0]) rightShaft();
    
    inputGear();
    outputGear();
    
    
    translate([2.1 + outputGearOffset,0,0]) bearing();
    rotateCopy([0,180,0]) translate([46,0,0]) bearing();
   
    // add wheels
    rotateCopy([0,180,0]) translate([50,0,0]) wheel();
  }
}


// axle housing top
module housingTop()
{
  difference()
  {
    union()
    {
      // basic axle
      rotate([0,90,0]) cylinder(d = 20, h = 99, center = true);
      
      mirrorCopy([1,0,0])
      {
        // add support to mount axle
        translate([20,0,0]) cube([10,18,25], center = true);
      
        // add support to mount bottom
        mirrorCopy([0,1,0]) translate([30,8,0]) cylinder(d = 8, h = 9.001, center = true);
      }
    }
    
    // add hole for shaft
    rotate([0,90,0]) cylinder(d = 8, h = 100, center = true);
    
    mirrorCopy([1,0,0])
    {
      mirrorCopy([0,1,0])
      {
        // add holes for screws to mount bottom
        translate([30,8,0]) cylinder(d = 4.1, h = 30, center = true);
      
        // add holes for screw heads
        translate([30,8,4.5]) cylinder(d = 7.5, h = 5);
      }
      
      // add holes for screws to mount axle
      translate([20,0,0]) cylinder(d = 4.1, h = 15);
      
      // add holes for nuts
      translate([20,0,0]) cylinder(d = 8, h = 8, $fn = 6);
    }
    
    // remove top half
    translate([0,0,-8]) cube([100,26,16], center = true);
  }
}


// axle housing bottom
module housingBottom()
{
  difference()
  {
    union()
    {
      // basic axle
      rotate([0,90,0]) cylinder(d = 20, h = 99, center = true);
      
      // add support to mount top
      mirrorCopy([1,0,0]) mirrorCopy([0,1,0])
        translate([30,8,0]) cylinder(d = 8, h = 9.001, center = true);
    }
    
    // add hole for shaft
    rotate([0,90,0]) cylinder(d = 8, h = 100, center = true);
    
    mirrorCopy([1,0,0]) mirrorCopy([0,1,0])
    {
      // add holes for screws to mount top
      translate([30,8,0]) cylinder(d = 4.1, h = 20, center = true);
    
      // add holes for nuts
      translate([30,8,-8]) cylinder(d = 8, h = 3.5, $fn = 6);
    }
    
    // remove top half
    translate([0,0,6]) cube([100,26,12], center = true);
  }
}


// left shaft
module leftShaft()
{
  difference()
  {
    union() 
    {
      translate([outputGearOffset + 0.1,0,0]) rotate([0,90,0]) 
        cylinder(d = 5.9, h = 50 - outputGearOffset);
      
      translate([-5,0,0]) rotate([45,0,0]) rotate([0,90,0]) 
        cylinder(d = 5.9, h = 60, $fn = 4);
      
      translate([43.9,0,0]) rotate([0,-90,0])
        cylinder(d1 = 8, d2 = 5.9, h = 2);
    }
     
    translate([0,0,-10 - sqrt(5.9^2/2)/2]) cube([120,20,20], center = true);
  }
}


// right shaft
module rightShaft()
{
  difference()
  {
    union() 
    {
      translate([-5.1,0,0]) rotate([0,-90,0]) 
        cylinder(d = 5.9, h = 44.9);
      
      translate([-10,0,0]) rotate([45,0,0]) rotate([0,-90,0]) 
        cylinder(d = 5.9, h = 45, $fn = 4);
      
      translate([-43.9,0,0]) rotate([0,90,0])
        cylinder(d1 = 8, d2 = 5.9, h = 2);
        
      rotate([0,-90,0]) difference()
      {
        cylinder(d = 9, h = 6);
        cylinder(d = 6, h = 10.2, $fn = 4, center = true);
      }
      
      translate([-6,0,0]) rotate([0,-90,0])
        cylinder(d1 = 9, d2 = 5.9, h = 6);
    }
     
    translate([0,0,-10 - sqrt(5.9^2/2)/2]) cube([120,20,20], center = true);
  }
}


// input gear
module inputGear()
{
  render() translate([0,inputGearOffset,0]) rotate([90,0,0]) 
    gear(15, 0.7, inputGearOffset/2, inputGearAngle, 4, 4);
}


// output gear
module outputGear()
{
  render() translate([outputGearOffset,0,0]) rotate([0,-90,0])
    gear(30, 0.7, outputGearOffset/2, outputGearAngle, 6, 4);
}


// bearing 
module bearing()
{
  rotate([0,90,0]) difference()
  {
    cylinder(d = 12, h = 4, center = true);
    
    cylinder(d = 6, h = 4.2, center = true);
  }
}

