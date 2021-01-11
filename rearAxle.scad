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

// wall thickness
thinWall = 1;
strongWall = 1.5;

// wheels
wheelWidth = 20;

// gears
inputGearSize = 10;
outputGearSize = 20;
gearModule = 0.9;
inputGearAngle = getConeAngle(inputGearSize, outputGearSize);
outputGearAngle = getConeAngle(outputGearSize, inputGearSize);
inputGearOffset = getBevelGearOffset(inputGearSize, inputGearAngle, gearModule);
outputGearOffset = getBevelGearOffset(outputGearSize, outputGearAngle, gearModule);

// bearings
inputBearingOuterDiameter = 8;
inputBearingInnerDiameter = 4;
inputBearingWidth = 3;
inputBearingOffset = inputBearingWidth/2 + inputGearOffset + 0.1;
outputBearingOuterDiameter = 12;
outputBearingInnerDiameter = 6;
outputBearingWidth = 4;
outputBearingOffset = outputBearingWidth/2 + outputGearOffset + 0.1;
wheelBearingOffset = outputBearingWidth/2 + thinWall + 0.5;

// shafts
inputShaftDiameter = inputBearingInnerDiameter - 0.1;
outputShaftDiameter = outputBearingInnerDiameter - 0.1;


// shows rear axle
rearAxle();


// rear axle
module rearAxle(width = 140)
{
  translate([0,0,-12.5])
  {
    // add housing
    housingWidth = width - 2*wheelWidth;
    //housingTop(housingWidth);
    //housingBottom(housingWidth);
    
    // add shaft
    shaftLength = housingWidth/2;
    leftShaft(shaftLength);
    rotate([45,0,0]) rightShaft(shaftLength);
    
    // add gears
    inputGear();
    outputGear();
    
    // add input bearing
    translate([0,inputBearingOffset,0]) inputBearing();
    
    // add output bearing
    translate([outputBearingOffset,0,0]) outputBearing();
    
    // add wheel bearing
    wheelBearingOffset = housingWidth/2 - wheelBearingOffset;
    rotateCopy([0,180,0]) translate([wheelBearingOffset,0,0]) outputBearing();
   
    // add wheels
    //rotateCopy([0,180,0]) translate([shaftLength,0,0]) wheel();
  }
}


// axle housing top
module housingTop(width)
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
module housingBottom(width)
{
  difference()
  {
    union()
    {
      rotate([0,90,0]) cylinder(d = 12, h = 99, center = true);
      translate([2,0,0]) rotate([0,90,0]) cylinder(d = 27, h = 7);
      translate([9,0,0]) rotate([0,90,0]) cylinder(d1 = 27, d2 = 12, h = 5);
      rotate([0,90,0]) cylinder(d1 = 16, d2 = 27, h = 2);
      rotate([0,-90,0]) cylinder(d = 16, h = 8);
      translate([-8,0,0]) rotate([0,-90,0]) cylinder(d1 = 16, d2 = 12, h = 5);
      mirrorCopy([1,0,0]) translate([42,0,0]) rotate([0,90,0]) cylinder(d = 16, h = 7.5);
      mirrorCopy([1,0,0]) translate([40,0,0]) rotate([0,90,0]) cylinder(d1 = 12, d2 = 16, h = 2);
      
      rotate([-90,0,0]) cylinder(d1 = 16, d2 = 17, h = 12);
      rotate([-90,0,0]) cylinder(d = 12, h = 15.5);
      translate([0,12,0]) rotate([-90,0,0]) cylinder(d1 = 17, d2 = 12, h = 2);
      
      
      // add support to mount top
      translate([10.5,9,0]) cylinder(d = 7, h = 4, center = true);
      translate([-9.5,8.5,0]) cylinder(d = 7, h = 4, center = true);
      translate([-1.5,-9,0]) cylinder(d = 7, h = 4, center = true);
    }
    
    rotate([0,90,0]) cylinder(d = 8, h = 100, center = true);
    translate([3,0,0]) rotate([0,90,0]) cylinder(d = 23, h = 4);
    translate([1,0,0]) rotate([0,90,0]) cylinder(d1 = 10, d2 = 23, h = 2);
    translate([1.7,0,0]) rotate([0,90,0]) cylinder(d = 12.1, h = 17.4, center = true);
    translate([10.3,0,0]) rotate([0,90,0]) cylinder(d1 = 11, d2 = 8, h = 3);
    translate([-7,0,0]) rotate([0,-90,0]) cylinder(d1 = 12.1, d2 = 8, h = 5);
    mirrorCopy([1,0,0]) translate([41.8,0,0]) rotate([0,90,0]) cylinder(d1 = 8, d2 = 12.1, h = 2);
    mirrorCopy([1,0,0]) translate([43.8,0,0]) rotate([0,90,0]) cylinder(d = 12.1, h = 3.2);
    
    
    rotate([-90,0,0]) cylinder(d = 7, h = 20);
    rotate([-90,0,0]) cylinder(d = 8.1, h = 14.3);
    translate([0,10,0]) rotate([-90,0,0]) cylinder(d1 = 14, d2 = 8.1, h = 2);
    rotate([-90,0,0]) cylinder(d1 = 4, d2 = 14, h = 10);
    
    // add holes for screws to mount top
    translate([10.5,9,0]) cylinder(d = 3.1, h = 30, center = true);
    translate([-9.5,8.5,0]) cylinder(d = 3.1, h = 30, center = true);
    translate([-1.5,-9,0]) cylinder(d = 3.1, h = 30, center = true);
    
    translate([10.5,9,-12]) cylinder(d = 6.4, h = 10, $fn = 6);
    translate([-9.5,8.5,-12]) cylinder(d = 6.4, h = 10, $fn = 6);
    translate([-1.5,-9,-12]) cylinder(d = 6.4, h = 10, $fn = 6);
    
    // remove top half
    translate([0,0,25]) cube([100,50,50], center = true);
  }
}


// left shaft
module leftShaft(length)
{
  difference()
  {
    union() 
    {
      // basic shaft
      shaftOffset = outputGearOffset + 0.1;
      shaftLength = length - shaftOffset;
      translate([shaftOffset,0,0]) rotate([0,90,0]) 
        cylinder(d = outputShaftDiameter, h = shaftLength);
      
      // add wheel and shaft connection
      shaftConnectionOffset = outputShaftDiameter - 0.3;
      shaftConnectionLength = length + shaftConnectionOffset + outputShaftDiameter;
      translate([-shaftConnectionOffset,0,0]) rotate([45,0,0]) rotate([0,90,0]) 
        cylinder(d = outputShaftDiameter, h = shaftConnectionLength, $fn = 4);
      
      // add wheel bearing stop
      bearingStopDiameter = outputShaftDiameter + 2*thinWall;
      bearingStopOffset = length - wheelBearingOffset - outputBearingWidth/2 - 0.1;
      translate([bearingStopOffset,0,0]) rotate([0,-90,0])
        cylinder(d1 = bearingStopDiameter, d2 = outputShaftDiameter, h = 2*thinWall);
    }
    
    // flat bottom
    boxLength = 2*length + 2*outputShaftDiameter + 1;
    boxSize = 2*outputShaftDiameter + 2*thinWall;
    bottomOffset = boxSize/2 + sqrt(outputShaftDiameter^2 / 2)/2;
    translate([0,0,-bottomOffset]) cube([boxLength,boxSize,boxSize], center = true);
  }
}


// right shaft
module rightShaft(length)
{
  difference()
  {
    union() 
    {
      // basic shaft
      shaftOffset = outputShaftDiameter + 0.1;
      shaftLength = length - shaftOffset;
      translate([-shaftOffset,0,0]) rotate([0,-90,0])
        cylinder(d = outputShaftDiameter, h = shaftLength);
      
      // add wheel connection
      wheelConnectionLength = shaftLength + outputShaftDiameter;
      translate([-shaftOffset-1,0,0]) rotate([45,0,0]) rotate([0,-90,0]) 
        cylinder(d = outputShaftDiameter, h = wheelConnectionLength-1, $fn = 4);
      
      // add wheel bearing stop
      bearingStopDiameter = outputShaftDiameter + 2*thinWall;
      bearingStopOffset = length - wheelBearingOffset - outputBearingWidth/2 - 0.1;
      translate([-bearingStopOffset,0,0]) rotate([0,90,0])
        cylinder(d1 = bearingStopDiameter, d2 = outputShaftDiameter, h = 2*thinWall);
      
      // add shaft connection
      shaftConnectionLength = shaftOffset + strongWall/2;
      shaftConnectionDiameter = outputShaftDiameter + 2*strongWall;
      translate([-0.1,0,0]) rotate([0,-90,0]) difference()
      {
        cylinder(d = shaftConnectionDiameter, h = shaftConnectionLength);
        
        // add hole for other shaft
        holeDiameter = outputShaftDiameter + 0.1;
        cylinder(d = holeDiameter, h = 2*shaftOffset, $fn = 4, center = true);
      }
      
      // add shaft reduction
      shaftReductionLength = 3*strongWall;
      shaftReductionOffset = shaftConnectionLength + 0.1;
      translate([-shaftReductionOffset,0,0]) rotate([0,-90,0])
        cylinder(d1 = shaftConnectionDiameter, d2 = outputShaftDiameter, h = shaftReductionLength);
    }
    
    // flat bottom
    boxLength = 2*length + 2*outputShaftDiameter + 1;
    boxSize = 2*outputShaftDiameter + 2*strongWall;
    bottomOffset = boxSize/2 + sqrt(outputShaftDiameter^2 / 2)/2;
    translate([0,0,-bottomOffset]) cube([boxLength,boxSize,boxSize], center = true);
  }
}


// input gear
module inputGear()
{
  render()
  {
    // basic gear
    translate([0,inputGearOffset,0]) rotate([90,0,0]) 
      gear(inputGearSize, gearModule, inputGearOffset/2, inputGearAngle);
    
    // add input shaft
    inputShaftLength = inputBearingWidth + thinWall + 0.5;
    translate([0,inputGearOffset-1,0]) rotate([-90,0,0]) 
      cylinder(d = inputShaftDiameter, h = inputShaftLength+1);
    
    // add shaft connection
    shaftConnectionLenght = inputShaftLength + inputShaftDiameter;
    translate([0,inputGearOffset-1,0]) rotate([-90,0,0]) 
      cylinder(d = inputShaftDiameter, h = shaftConnectionLenght+1, $fn = 4);
  }
}


// output gear
module outputGear()
{
  render() 
  {
    // basic gear
    holeDiameter = outputShaftDiameter + 0.1;
    translate([outputGearOffset,0,0]) rotate([0,-90,0])
      gear(outputGearSize, gearModule, outputGearOffset/2, outputGearAngle, holeDiameter, 4);
    
    difference()
    {
      // add gear support
      supportDiameter = holeDiameter + 2*strongWall;
      translate([0.1,0,0]) rotate([0,90,0]) 
        cylinder(d = supportDiameter, h = outputGearOffset-1);
      
      // add hole to support
      rotate([45,0,0]) rotate([0,90,0])
        cylinder(d = holeDiameter, h = outputGearOffset, $fn = 4);
    }
  }
}


// input bearing 
module inputBearing()
{
  rotate([90,0,0]) difference()
  {
    // basic shape
    cylinder(d = inputBearingOuterDiameter, h = inputBearingWidth, center = true);
    
    // add hole
    cylinder(d = inputBearingInnerDiameter, h = inputBearingWidth+1, center = true);
  }
}


// output bearing 
module outputBearing()
{
  rotate([0,90,0]) difference()
  {
    // basic shape
    cylinder(d = outputBearingOuterDiameter, h = outputBearingWidth, center = true);
    
    // add hole
    cylinder(d = outputBearingInnerDiameter, h = outputBearingWidth+1, center = true);
  }
}

