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
inputBearingOuterDiameter = 8.5;
inputBearingInnerDiameter = 4;
inputBearingWidth = 3;
inputBearingOffset = inputBearingWidth/2 + inputGearOffset + 0.1;
outputBearingOuterDiameter = 12.5;
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
    // housing
    housingWidth = width - 2*wheelWidth;
    housingTop(housingWidth);
    housingBottom(housingWidth);
    
    // shaft
    shaftLength = housingWidth/2;
    leftShaft(shaftLength);
    rotate([45,0,0]) rightShaft(shaftLength);
    
    // gears
    inputGear();
    outputGear();
    
    // input bearing
    translate([0,-inputBearingOffset,0]) inputBearing();
    
    // output bearing
    translate([outputBearingOffset,0,0]) outputBearing();
    
    // wheel bearing
    wheelBearingOffset = housingWidth/2 - wheelBearingOffset;
    rotateCopy([0,180,0]) translate([wheelBearingOffset,0,0]) outputBearing();
   
    // wheels
    rotateCopy([0,180,0]) translate([shaftLength,0,0]) wheel();
  }
}


// axle housing top
module housingTop(width)
{
  difference()
  {
    // basic housing
    basicHousing(width);
    
    
    // remove top half
    translate([0,0,-25]) cube([width+1,50,50], center = true);
  }
}

// axle housing bottom
module housingBottom(width)
{
  difference()
  {
    // basic housing
    basicHousing(width);
    
    
    // remove top half
    translate([0,0,25]) cube([width+1,50,50], center = true);
  }
}


// basic axle housing
module basicHousing(width)
{
  difference()
  {
    // local definitions
    
    // output shaft
    housingWidth = width - 0.5;
    outputShaftHole = outputShaftDiameter + 2*thinWall;
    
    // bearings
    outputBearingHole = outputBearingOuterDiameter + 0.2;
    outputBearingHoleDepth = outputBearingWidth + 0.5;
    wheelBearingOffset = width/2 - wheelBearingOffset;
    
    // shaft connection
    shaftConnectionHole = outputShaftDiameter + 2*strongWall + 2*thinWall;
    shaftConnectionHoleDepth = outputShaftDiameter + strongWall/2 + thinWall + outputGearOffset;
    
    // output gear
    outputGearHole = 2*inputGearOffset + 2*thinWall;
    outputGearHoleDepth = outputGearOffset/2 + 2*thinWall;
    outputGearHoleOffset = outputGearOffset + thinWall;
    
    // input shaft
    inputBearingHole = inputBearingOuterDiameter + 0.2;
    inputBearingHoleDepth = inputBearingOffset + inputBearingWidth/2 + 0.2;
    
    // input gear
    inputGearHole = 2*outputGearOffset + 2*thinWall;
    inputGearHoleDepth = inputGearOffset/2 + 2*thinWall;
    inputGearHoleOffset = inputGearOffset + thinWall;
    
    union()
    {
      // shaft housing
      housingDiameter = outputShaftHole + 2*strongWall;
      rotate([0,90,0]) cylinder(d = housingDiameter, h = housingWidth, center = true);
      
      // housing for output bearing
      outputBearingHousingDiameter = outputBearingHole + 2*strongWall;
      outputBearingHousingWidth = outputBearingHoleDepth + 2*thinWall;
      translate([outputBearingOffset,0,0]) rotate([0,90,0]) 
        cylinder(d = outputBearingHousingDiameter, h = outputBearingHousingWidth, center = true);
      
      // housing for wheel bearing
      mirrorCopy([1,0,0]) translate([wheelBearingOffset,0,0]) rotate([0,90,0]) 
        cylinder(d = outputBearingHousingDiameter, h = outputBearingHousingWidth, center = true);
      
      // housing for shaft connection
      shaftConnectionHousingDiameter = shaftConnectionHole + 2*strongWall;
      shaftConnectionHousingWidth = shaftConnectionHoleDepth + thinWall;
      translate([outputGearOffset,0,0]) rotate([0,-90,0]) 
        cylinder(d = shaftConnectionHousingDiameter, h = shaftConnectionHousingWidth);
      
      // housing for output gear
      outputGearHousingDiameter = outputGearHole + 2*strongWall;
      outputGearHousingOffset = outputGearHoleOffset + thinWall;
      outputGearHousingWidth = outputGearHoleDepth + 2*thinWall;
      translate([outputGearHousingOffset,0,0]) rotate([0,-90,0])
        cylinder(d = outputGearHousingDiameter, h = outputGearHousingWidth);
      
      
      //translate([9,0,0]) rotate([0,90,0]) cylinder(d1 = 27, d2 = 12, h = 5);
      //rotate([0,90,0]) cylinder(d1 = 16, d2 = 27, h = 2);
      //translate([-8,0,0]) rotate([0,-90,0]) cylinder(d1 = 16, d2 = 12, h = 5);
      
      //mirrorCopy([1,0,0]) translate([40,0,0]) rotate([0,90,0]) cylinder(d1 = 12, d2 = 16, h = 2);
      
      // housing for input bearing
      inputBearingHousingDiameter = inputBearingHole + 2*strongWall;
      inputBearingHousingWidth = inputBearingHoleDepth + thinWall;
      rotate([90,0,0]) cylinder(d = inputBearingHousingDiameter, h = inputBearingHousingWidth);
      
      // housing for input gear
      inputGearHousingDiameter = inputGearHole + 2*strongWall;
      inputGearHousingOffset = inputGearHoleOffset + thinWall;
      inputGearHousingWidth = inputGearHoleDepth + 2*thinWall;
      translate([0,-inputGearHousingOffset,0]) rotate([-90,0,0])
        cylinder(d = inputGearHousingDiameter, h = inputGearHousingWidth);
      
      
      //rotate([-90,0,0]) cylinder(d1 = 16, d2 = 17, h = 12);
      //rotate([-90,0,0]) cylinder(d = 12, h = 15.5);
      //translate([0,12,0]) rotate([-90,0,0]) cylinder(d1 = 17, d2 = 12, h = 2);
      
      
      // support to mount top
      //translate([10.5,9,0]) cylinder(d = 7, h = 4, center = true);
      //translate([-9.5,8.5,0]) cylinder(d = 7, h = 4, center = true);
      //translate([-1.5,-9,0]) cylinder(d = 7, h = 4, center = true);
    }
    
    // hole for output shaft
    rotate([0,90,0]) cylinder(d = outputShaftHole, h = housingWidth+1, center = true);
    
    // hole for output bearing
    translate([outputBearingOffset,0,0]) rotate([0,90,0]) 
      cylinder(d = outputBearingHole, h = outputBearingHoleDepth, center = true);
    
    // holes for wheel bearings
    mirrorCopy([1,0,0]) translate([wheelBearingOffset,0,0]) rotate([0,90,0]) 
      cylinder(d = outputBearingHole, h = outputBearingHoleDepth, center = true);
    
    // hole for shaft connection
    translate([outputGearOffset,0,0]) rotate([0,-90,0]) 
      cylinder(d = shaftConnectionHole, h = shaftConnectionHoleDepth);
    
    // hole for output gear
    translate([outputGearHoleOffset,0,0]) rotate([0,-90,0]) 
      cylinder(d = outputGearHole, h = outputGearHoleDepth);
    
    //translate([3,0,0]) rotate([0,90,0]) cylinder(d = 23, h = 4);
    //translate([1,0,0]) rotate([0,90,0]) cylinder(d1 = 10, d2 = 23, h = 2);
    //translate([1.7,0,0]) rotate([0,90,0]) cylinder(d = 12.1, h = 17.4, center = true);
    //translate([10.3,0,0]) rotate([0,90,0]) cylinder(d1 = 11, d2 = 8, h = 3);
    //translate([-7,0,0]) rotate([0,-90,0]) cylinder(d1 = 12.1, d2 = 8, h = 5);
    //mirrorCopy([1,0,0]) translate([41.8,0,0]) rotate([0,90,0]) cylinder(d1 = 8, d2 = 12.1, h = 2);
    //mirrorCopy([1,0,0]) translate([43.8,0,0]) rotate([0,90,0]) cylinder(d = 12.1, h = 3.2);
    
    // hole for input shaft
    inputShaftHole = inputShaftDiameter + 2*thinWall;
    inputShaftHoleDepth = inputBearingHoleDepth + thinWall + 1;
    rotate([90,0,0]) cylinder(d = inputShaftHole, h = inputShaftHoleDepth);
    
    // hole for input bearing
    rotate([90,0,0]) cylinder(d = inputBearingHole, h = inputBearingHoleDepth);
    
    // hole for input gear
    translate([0,-inputGearHoleOffset,0]) rotate([-90,0,0]) 
      cylinder(d = inputGearHole, h = inputGearHoleDepth);
    
    
    //rotate([-90,0,0]) cylinder(d = 7, h = 20);
    //rotate([-90,0,0]) cylinder(d = 8.1, h = 14.3);
    //translate([0,10,0]) rotate([-90,0,0]) cylinder(d1 = 14, d2 = 8.1, h = 2);
    //rotate([-90,0,0]) cylinder(d1 = 4, d2 = 14, h = 10);
    
    // holes for screws to mount top
    //translate([10.5,9,0]) cylinder(d = 3.1, h = 30, center = true);
    //translate([-9.5,8.5,0]) cylinder(d = 3.1, h = 30, center = true);
    //translate([-1.5,-9,0]) cylinder(d = 3.1, h = 30, center = true);
    
    //translate([10.5,9,-12]) cylinder(d = 6.4, h = 10, $fn = 6);
    //translate([-9.5,8.5,-12]) cylinder(d = 6.4, h = 10, $fn = 6);
    //translate([-1.5,-9,-12]) cylinder(d = 6.4, h = 10, $fn = 6);
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
      
      // wheel and shaft connection
      shaftConnectionOffset = outputShaftDiameter - 0.3;
      shaftConnectionLength = length + shaftConnectionOffset + outputShaftDiameter;
      translate([-shaftConnectionOffset,0,0]) rotate([45,0,0]) rotate([0,90,0]) 
        cylinder(d = outputShaftDiameter, h = shaftConnectionLength, $fn = 4);
      
      // wheel bearing stop
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
      
      // wheel connection
      wheelConnectionLength = shaftLength + outputShaftDiameter;
      translate([-shaftOffset-1,0,0]) rotate([45,0,0]) rotate([0,-90,0]) 
        cylinder(d = outputShaftDiameter, h = wheelConnectionLength-1, $fn = 4);
      
      // wheel bearing stop
      bearingStopDiameter = outputShaftDiameter + 2*thinWall;
      bearingStopOffset = length - wheelBearingOffset - outputBearingWidth/2 - 0.1;
      translate([-bearingStopOffset,0,0]) rotate([0,90,0])
        cylinder(d1 = bearingStopDiameter, d2 = outputShaftDiameter, h = 2*thinWall);
      
      // shaft connection
      shaftConnectionLength = shaftOffset + strongWall/2;
      shaftConnectionDiameter = outputShaftDiameter + 2*strongWall;
      translate([-0.1,0,0]) rotate([0,-90,0]) difference()
      {
        cylinder(d = shaftConnectionDiameter, h = shaftConnectionLength);
        
        // hole for other shaft
        holeDiameter = outputShaftDiameter + 0.1;
        cylinder(d = holeDiameter, h = 2*shaftOffset, $fn = 4, center = true);
      }
      
      // shaft reduction
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
    translate([0,-inputGearOffset,0]) rotate([-90,0,0]) 
      gear(inputGearSize, gearModule, inputGearOffset/2, inputGearAngle);
    
    // input shaft
    inputShaftLength = inputBearingWidth + thinWall + 0.5;
    translate([0,-inputGearOffset+1,0]) rotate([90,0,0]) 
      cylinder(d = inputShaftDiameter, h = inputShaftLength+1);
    
    // shaft connection
    shaftConnectionLenght = inputShaftLength + inputShaftDiameter;
    translate([0,-inputGearOffset+1,0]) rotate([90,0,0]) 
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
      // gear support
      supportDiameter = holeDiameter + 2*strongWall;
      translate([0.1,0,0]) rotate([0,90,0]) 
        cylinder(d = supportDiameter, h = outputGearOffset-1);
      
      // hole to support
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
    
    // hole
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
    
    // hole
    cylinder(d = outputBearingInnerDiameter, h = outputBearingWidth+1, center = true);
  }
}

