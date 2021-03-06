// this file defines the rear axle


// used modules
use <../../../modules/copy.scad>
use <../../../modules/transform.scad>
use <../../../modules/gears.scad>


// used parts
use <../../wheel/wheel.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// wall thickness
thinWall = 1;
strongWall = 1.5;

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
inputBearingInnerDiameter = 5;
inputBearingWidth = 2;
inputBearingOffset1 = inputBearingWidth/2 + inputGearOffset + 2*thinWall + 0.1;
inputBearingOffset2 = inputBearingOffset1 + inputBearingWidth + thinWall;
outputBearingOuterDiameter = 10.5;
outputBearingInnerDiameter = 6;
outputBearingWidth = 3;
outputBearingOffset = outputBearingWidth/2 + outputGearOffset + 0.1;
wheelBearingOffset = outputBearingWidth/2 + thinWall + 0.5;

// wheel hubs
wheelScrewLength = strongWall + 2*getRimThickness() + 0.2;
wheelHubLatchSize = 4;
wheelHubLatchOffset = wheelScrewLength + wheelHubLatchSize/2 + 2*thinWall;

// shafts
inputShaftDiameter = inputBearingInnerDiameter - 0.1;
outputShaftDiameter = outputBearingInnerDiameter - 0.1;
outputShaftConnectionLenght = wheelHubLatchOffset + wheelHubLatchSize/2 + strongWall;

// screws
screwDiameter = 3;
screwHeadDiameter = 5.5;
nutDiameter = 6.01;
nutWidth = 2.4;
nutHoleDepth = nutWidth + 0.2;

// axle mount
axleMountDistance = 40;
axleMountSize = nutDiameter + 2*strongWall;
axleMountNutHoleDepth = nutHoleDepth + outputShaftDiameter/2 + thinWall;
axleMountHeight = axleMountNutHoleDepth + strongWall;


// shows rear axle
rearAxle();


// assembled rear axle
module rearAxle(width = 140)
{
  translateZ(-axleMountHeight)
  {
    // wheels
    wheelOffset = width/2 - getWheelWidth();
    
    // shafts
    shaftLength = wheelOffset - getRimThickness() - strongWall;
    leftShaft(shaftLength);
    rotateX(45) rightShaft(shaftLength);
    inputShaft();
    
    // housing
    housingWidth = 2*shaftLength;
    housingTop(housingWidth);
    housingBottom(housingWidth);
    
    // gears
    inputGear();
    outputGear();
    
    // input bearings
    translateY(-inputBearingOffset1) inputBearing();
    translateY(-inputBearingOffset2) inputBearing();
    
    // output bearing
    translateX(outputBearingOffset) outputBearing();
    
    rotateCopyY(180)
    {
      // wheel bearing
      wheelBearingOffset = shaftLength - wheelBearingOffset;
      translateX(wheelBearingOffset) outputBearing();
      
      // wheelHubs
      translateX(shaftLength)
      {
        wheelHub();
        wheelHubLatch();
      }
   
      // wheels
      translateX(wheelOffset)
      {
        rotateCopyY(180) wheel();
        wheelClip();
      }
    }
  }
}


// axle housing top
module housingTop(width)
{
  render() difference()
  {
    // basic housing
    basicHousing(width);
    
    // remove top half
    translateZ(-25.2) cube([width+1,50,50], center = true);
  }
}

// axle housing bottom
module housingBottom(width)
{
  render() difference()
  {
    // basic housing
    basicHousing(width);
    
    // remove top half
    translateZ(25.2) cube([width+1,50,50], center = true);
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
    shaftTransitionWidth = 3*strongWall;
    
    // output gear
    outputGearHole = 2*inputGearOffset + 2*thinWall;
    outputGearHoleDepth = outputGearOffset/2 + 2*thinWall;
    outputGearHoleOffset = outputGearOffset + thinWall;
    
    // input shaft
    inputBearingHole = inputBearingOuterDiameter + 0.2;
    inputBearingHoleDepth = inputBearingWidth + 0.2;
    
    // input gear
    inputGearHole = 2*outputGearOffset + 2*thinWall;
    inputGearHoleDepth = inputGearOffset/2 + 2*thinWall;
    inputGearHoleOffset = inputGearOffset + thinWall;
    
    // housing mount
    screwHole = screwDiameter + 0.2;
    nutHole = nutDiameter + 0.2;
    supportThickness = 4*strongWall;
    leftScrewX = outputGearHoleOffset + thinWall + nutDiameter/2;
    leftScrewY = sqrt(outputBearingHole^2 - supportThickness^2)/2 + thinWall + nutDiameter/2;
    rightScrewX = sqrt(inputGearHole^2 - supportThickness^2)/2 + thinWall + nutDiameter/2;
    holeDiameter = (shaftConnectionHole + outputShaftHole)/2;
    rightScrewY = sqrt(holeDiameter^2 - supportThickness^2)/2 + thinWall + nutDiameter/2;
    backScrewX = (outputGearHoleOffset - outputGearHoleDepth)/2 - thinWall - nutDiameter/2;
    backScrewY = sqrt(shaftConnectionHole^2 - supportThickness^2)/2 + thinWall + nutDiameter/2;
    wheelScrewX = wheelBearingOffset - outputBearingHoleDepth/2 - thinWall - screwDiameter/2;
    wheelScrewY = sqrt(outputShaftHole^2 - supportThickness^2)/2 + thinWall + nutDiameter/2;
    
    // axle mount
    axleMountOffset = axleMountDistance/2;
    
    union()
    {
      // shaft housing
      housingDiameter = outputShaftHole + 2*strongWall;
      rotateY(90) cylinder(d = housingDiameter, h = housingWidth, center = true);
      
      // housing for output gear
      outputGearHousingDiameter = outputGearHole + 2*strongWall;
      outputGearHousingOffset = outputGearHoleOffset + thinWall;
      outputGearHousingWidth = outputGearHoleDepth + 2*thinWall;
      translateX(outputGearHousingOffset) rotateY(-90)
        cylinder(d = outputGearHousingDiameter, h = outputGearHousingWidth);
      
      // housing for output bearing
      outputBearingHousingDiameter = outputBearingHole + 2*strongWall;
      outputBearingHousingWidth = outputBearingHoleDepth + 2*thinWall;
      translateX(outputBearingOffset) rotateY(90) 
        cylinder(d = outputBearingHousingDiameter, h = outputBearingHousingWidth, center = true);
      
      // transition to output bearing
      outputBearingTransitionOffset = outputBearingOffset + outputBearingHousingWidth/2;
      
      // from output gear
      outputBearingTransitionWidth1 = outputBearingTransitionOffset - outputGearHousingOffset;
      translateX(outputBearingTransitionOffset) rotateY(-90) 
        cylinder(d1 = outputBearingHousingDiameter, d2 = outputGearHousingDiameter, 
          h = outputBearingTransitionWidth1);
        
      // from shaft
      outputBearingTransitionWidth2 = (outputBearingHousingDiameter - housingDiameter)/2;
      translateX(outputBearingTransitionOffset) rotateY(90) 
        cylinder(d1 = outputBearingHousingDiameter, d2 = housingDiameter, 
          h = outputBearingTransitionWidth2);
      
      // housing for wheel bearing
      mirrorCopyX() translateX(wheelBearingOffset) rotateY(90) 
        cylinder(d = outputBearingHousingDiameter, h = outputBearingHousingWidth, center = true);
      
      // transition to wheel bearing housing
      wheelBearingTransitionOffset = wheelBearingOffset - outputBearingHousingWidth/2;
      wheelBearingTransitionWidth = (outputBearingHousingDiameter - housingDiameter)/2;
      mirrorCopyX() translateX(wheelBearingTransitionOffset) rotateY(-90) 
        cylinder(d1 = outputBearingHousingDiameter, d2 = housingDiameter, 
          h = wheelBearingTransitionWidth);
      
      // housing for shaft connection
      shaftConnectionHousingDiameter = shaftConnectionHole + 2*strongWall;
      shaftConnectionHousingWidth = shaftConnectionHoleDepth + thinWall;
      translateX(outputGearOffset) rotateY(-90) 
        cylinder(d = shaftConnectionHousingDiameter, h = shaftConnectionHousingWidth);
      
      // transition to output gear
      outputGearTransitionOffset = outputGearHousingOffset - outputGearHousingWidth;
      outputGearTransitionWidth = (outputGearHousingDiameter - shaftConnectionHousingDiameter)/3;
      translateX(outputGearTransitionOffset) rotateY(-90) 
        cylinder(d1 = outputGearHousingDiameter, d2 = shaftConnectionHousingDiameter, 
          h = outputGearTransitionWidth);
      
      // transition to shaft connection
      shaftGearTransitionOffset = shaftConnectionHousingWidth - outputGearOffset;
      translateX(-shaftGearTransitionOffset) rotateY(-90) 
        cylinder(d1 = shaftConnectionHousingDiameter, d2 = housingDiameter, 
          h = shaftTransitionWidth);
      
      // housing for input gear
      inputGearHousingDiameter = inputGearHole + 2*strongWall;
      inputGearHousingOffset = inputGearHoleOffset + thinWall;
      inputGearHousingWidth = inputGearHoleDepth + 2*thinWall;
      translateY(-inputGearHousingOffset) rotateX(-90)
        cylinder(d = inputGearHousingDiameter, h = inputGearHousingWidth);
        
      // transition to input gear
      inputGearTransitionOffset = inputGearHousingOffset - inputGearHousingWidth;
      translateY(-inputGearTransitionOffset) rotateX(-90) 
        cylinder(d1 = inputGearHousingDiameter, d2 = shaftConnectionHousingDiameter, 
          h = inputGearTransitionOffset);
      
      // housing for input bearing
      inputBearingHousingDiameter = inputBearingHole + 2*strongWall;
      inputBearingHousingWidth = inputBearingOffset2 + inputBearingHoleDepth/2 + thinWall;
      rotateX(90) cylinder(d = inputBearingHousingDiameter, h = inputBearingHousingWidth);
      
      // transition to input bearing
      inputBearingTransitionWidth = inputBearingHousingWidth - inputGearHousingOffset;
      translateY(-inputGearHousingOffset) rotateX(90) 
        cylinder(d1 = inputGearHousingDiameter, d2 = inputBearingHousingDiameter, 
          h = inputBearingTransitionWidth);
      
      // support to screw halfs together
      supportDiameter = max(screwHole + 2*strongWall, nutHole);
      
      // left
      translate([leftScrewX,-leftScrewY,0])
        cylinder(d = supportDiameter, h = supportThickness, center = true);
      
      // right
      translate([-rightScrewX,-rightScrewY,0]) 
        cylinder(d = supportDiameter, h = supportThickness, center = true);
      
      // back
      translate([backScrewX,backScrewY,0]) 
        cylinder(d = supportDiameter, h = supportThickness, center = true);
        
      // wheel
      mirrorCopyX() mirrorCopyY() translate([wheelScrewX,wheelScrewY,0]) 
        cylinder(d = supportDiameter, h = supportThickness, center = true);
      
      // support to mount axle
      mirrorCopyX() translate([axleMountOffset,0,axleMountHeight/2])
        cube([axleMountSize,axleMountSize,axleMountHeight], center = true);
    }
    
    // hole for output shaft
    rotateY(90) cylinder(d = outputShaftHole, h = housingWidth+1, center = true);
    
    // hole for output gear
    translateX(outputGearHoleOffset) rotateY(-90) 
      cylinder(d = outputGearHole, h = outputGearHoleDepth);
        
    // transition to output gear
    outputGearTransitionOffset = outputGearHoleOffset - outputGearHoleDepth;
    translateX(outputGearTransitionOffset) rotateY(-90) 
      cylinder(d1 = outputGearHole, d2 = shaftConnectionHole, 
        h = outputGearTransitionOffset);
    
    // hole for output bearing
    translateX(outputBearingOffset) rotateY(90) 
      cylinder(d = outputBearingHole, h = outputBearingHoleDepth, center = true);
    
    // transition to output bearing
    outputBearingTransitionOffset = outputBearingOffset + outputBearingHoleDepth/2;
    outputBearingTransitionWidth = 2*thinWall;
    outputBearingTransitionDiameter = outputBearingHole - 2*thinWall;
    translateX(outputBearingTransitionOffset) rotateY(90) 
      cylinder(d1 = outputBearingTransitionDiameter, d2 = outputShaftHole, 
        h = outputBearingTransitionWidth);
    
    // holes for wheel bearings
    mirrorCopyX() translateX(wheelBearingOffset) rotateY(90) 
      cylinder(d = outputBearingHole, h = outputBearingHoleDepth, center = true);

    // transition to wheel bearings
    wheelBearingTransitionOffset = wheelBearingOffset - outputBearingHoleDepth/2;
    wheelBearingTransitionWidth = 2*thinWall;
    mirrorCopyX() translateX(wheelBearingTransitionOffset) rotateY(-90) 
      cylinder(d1 = outputBearingTransitionDiameter, d2 = outputShaftHole, 
        h = wheelBearingTransitionWidth);
    
    // hole for shaft connection
    translateX(outputGearOffset) rotateY(-90) 
      cylinder(d = shaftConnectionHole, h = shaftConnectionHoleDepth);

    // transition to shaft connection
    shaftTransitionOffset = shaftConnectionHoleDepth - outputGearOffset;
    translateX(-shaftTransitionOffset) rotateY(-90) 
      cylinder(d1 = shaftConnectionHole, d2 = outputShaftHole, h = shaftTransitionWidth);

    // hole for input shaft
    inputShaftHole = inputShaftDiameter + thinWall;
    inputShaftHoleDepth = inputBearingOffset2 + inputBearingHoleDepth/2 + thinWall + 1;
    rotateX(90) cylinder(d = inputShaftHole, h = inputShaftHoleDepth);
    
    // hole for input gear
    translateY(-inputGearHoleOffset) rotateX(-90) 
      cylinder(d = inputGearHole, h = inputGearHoleDepth);
      
    // hole for input end stop
    inputEndStopHole = inputBearingHole - 2*thinWall;
    rotateX(90) cylinder(d = inputEndStopHole, h = inputBearingOffset2);
        
    // transition to input gear
    inputGearTransitionOffset = inputGearHoleOffset - inputGearHoleDepth;
    translateY(-inputGearTransitionOffset) rotateX(-90) 
      cylinder(d1 = inputGearHole, d2 = shaftConnectionHole, 
        h = inputGearTransitionOffset);
    
    // holes for input bearings
    translateY(-inputBearingOffset1) rotateX(90) 
      cylinder(d = inputBearingHole, h = inputBearingHoleDepth, center = true);
    translateY(-inputBearingOffset2) rotateX(90) 
      cylinder(d = inputBearingHole, h = inputBearingHoleDepth, center = true);
    
    // holes to screw halfs together
    screwHeadHole = screwHeadDiameter + 0.2;
    screwHeadOffset = supportThickness/2;
    nutHoleOffset = nutHoleDepth + supportThickness/2;
    
    // left
    translate([leftScrewX,-leftScrewY,0])
    {
      // hole for screw
      cylinder(d = screwHole, h = supportThickness+1, center = true);
      
      // hole for screw head
      translateZ(screwHeadOffset) cylinder(d = screwHeadHole, h = outputGearHole);
      
      // hole for nut
      translateZ(-nutHoleOffset) cylinder(d = nutHole, h = nutHoleDepth, $fn = 6);
    }
    
    // right
    translate([-rightScrewX,-rightScrewY,0]) 
    {
      // hole for screw
      cylinder(d = screwHole, h = supportThickness+1, center = true);
      
      // hole for screw head
      translateZ(screwHeadOffset) cylinder(d = screwHeadHole, h = outputGearHole);
      
      // hole for nut
      translateZ(-nutHoleOffset) cylinder(d = nutHole, h = nutHoleDepth, $fn = 6);
    }
    
    // back
    translate([backScrewX,backScrewY,0]) 
    {
      // hole for screw
      cylinder(d = screwHole, h = supportThickness+1, center = true);
      
      // hole for screw head
      translateZ(screwHeadOffset) cylinder(d = screwHeadHole, h = outputGearHole);
      
      // hole for nut
      translateZ(-nutHoleOffset) cylinder(d = nutHole, h = nutHoleDepth, $fn = 6);
    }
    
    // wheel
    mirrorCopyX() mirrorCopyY() translate([wheelScrewX,wheelScrewY,0]) 
    {
      // hole for screw
      cylinder(d = screwHole, h = supportThickness+1, center = true);
      
      // hole for screw head
      translateZ(screwHeadOffset) cylinder(d = screwHeadHole, h = outputGearHole);
      
      // hole for nut
      translateZ(-nutHoleOffset) cylinder(d = nutHole, h = nutHoleDepth, $fn = 6);
    }
     
    // holes to mount axle
    mirrorCopyX() translateX(axleMountOffset)
    {
      // hole for screws
      cylinder(d = screwHole, h = axleMountHeight+1);
    
      // hole for nuts
      cylinder(d = nutHole, h = axleMountNutHoleDepth, $fn = 6);
    }
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
      translateX(shaftOffset) rotateY(90) 
        cylinder(d = outputShaftDiameter, h = shaftLength);
      
      // wheel and shaft connection
      shaftConnectionOffset = outputShaftDiameter - 0.3;
      shaftConnectionLength = length + shaftConnectionOffset + outputShaftConnectionLenght;
      translateX(-shaftConnectionOffset) rotateX(45) rotateY(90) 
        cylinder(d = outputShaftDiameter, h = shaftConnectionLength, $fn = 4);
      
      // wheel bearing stop
      bearingStopDiameter = outputShaftDiameter + 2*thinWall;
      bearingStopOffset = length - wheelBearingOffset - outputBearingWidth/2 - 0.1;
      translateX(bearingStopOffset) rotateY(-90)
        cylinder(d1 = bearingStopDiameter, d2 = outputShaftDiameter, h = 2*thinWall);
    }
    
    // hole for wheel hub latch
    wheelHubLatchOffset = wheelHubLatchOffset + length;
    wheelHubLatchThickness = strongWall + 0.2;
    translateX(wheelHubLatchOffset)
      cube([wheelHubLatchSize,wheelHubLatchThickness,outputShaftDiameter], center = true);
    
    // flat bottom
    boxLength = 2*length + 2*outputShaftConnectionLenght + 1;
    boxSize = 2*outputShaftDiameter + 2*thinWall;
    bottomOffset = boxSize/2 + sqrt(outputShaftDiameter^2 / 2)/2;
    translateZ(-bottomOffset) cube([boxLength,boxSize,boxSize], center = true);
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
      translateX(-shaftOffset) rotateY(-90)
        cylinder(d = outputShaftDiameter, h = shaftLength);
      
      // wheel connection
      wheelConnectionLength = shaftLength + outputShaftConnectionLenght;
      translateX(-shaftOffset-1) rotateX(45) rotateY(-90) 
        cylinder(d = outputShaftDiameter, h = wheelConnectionLength-1, $fn = 4);
      
      // wheel bearing stop
      bearingStopDiameter = outputShaftDiameter + 2*thinWall;
      bearingStopOffset = length - wheelBearingOffset - outputBearingWidth/2 - 0.1;
      translateX(-bearingStopOffset) rotateY(90)
        cylinder(d1 = bearingStopDiameter, d2 = outputShaftDiameter, h = 2*thinWall);
      
      // shaft connection
      shaftConnectionLength = shaftOffset + strongWall/2;
      shaftConnectionDiameter = outputShaftDiameter + 2*strongWall;
      translateX(-0.1) rotateY(-90) difference()
      {
        cylinder(d = shaftConnectionDiameter, h = shaftConnectionLength);
        
        // hole for other shaft
        holeDiameter = outputShaftDiameter + 0.1;
        cylinder(d = holeDiameter, h = 2*shaftOffset, $fn = 4, center = true);
      }
      
      // shaft reduction
      shaftReductionLength = 3*strongWall;
      shaftReductionOffset = shaftConnectionLength + 0.1;
      translateX(-shaftReductionOffset) rotateY(-90)
        cylinder(d1 = shaftConnectionDiameter, d2 = outputShaftDiameter, h = shaftReductionLength);
    }
    
    // hole for wheel hub latch
    wheelHubLatchOffset = wheelHubLatchOffset + length;
    wheelHubLatchThickness = strongWall + 0.2;
    translateX(-wheelHubLatchOffset)
      cube([wheelHubLatchSize,wheelHubLatchThickness,outputShaftDiameter], center = true);
    
    // flat bottom
    boxLength = 2*length + 2*outputShaftConnectionLenght + 1;
    boxSize = 2*outputShaftDiameter + 2*strongWall;
    bottomOffset = boxSize/2 + sqrt(outputShaftDiameter^2 / 2)/2;
    translateZ(-bottomOffset) cube([boxLength,boxSize,boxSize], center = true);
  }
}


// input shaft
module inputShaft()
{
  rotateY(45) difference()
  {
    rotateY(45) rotateX(90)
    {
      // input shaft
      inputShaftLength = 2*inputBearingWidth + thinWall + strongWall;
      inputShaftOffset = inputBearingOffset1 - inputBearingWidth/2;
      translateZ(inputShaftOffset)
        cylinder(d = inputShaftDiameter, h = inputShaftLength);
      
      // shaft connection
      shaftConnectionLenght = inputShaftLength + thinWall + strongWall + inputShaftDiameter;
      inputShaftConnectionOffset = inputGearOffset - 2*thinWall;
      translateZ(inputShaftConnectionOffset)
        cylinder(d = inputShaftDiameter, h = shaftConnectionLenght+2, $fn = 4);
      
      // end stop
      endStopOffset = inputBearingOffset1 + inputBearingWidth/2;
      endStopDiameter = inputShaftDiameter + thinWall;
      translateZ(endStopOffset)
        cylinder(d = endStopDiameter, h = thinWall);
    }
    
    // flat bottom
    boxLength = 3*(inputBearingOffset2 + inputBearingWidth + inputShaftDiameter);
    boxSize = 2*inputShaftDiameter;
    bottomOffset = boxSize/2 + sqrt(inputShaftDiameter^2 / 2)/2;
    translateZ(-bottomOffset) cube([boxSize,boxLength,boxSize], center = true);
  }
}


// wheel hub
module wheelHub()
{
  rotateY(90) difference()
  {
    union()
    {
      // basic wheel hub
      wheelHubDiameter = getPitchCircleDiameter() + getWheelScrewDiameter();
      cylinder(d = wheelHubDiameter, h = strongWall);
      
      // shaft mount
      shaftMountDiameter = getRimHoleDiameter() - 0.3;
      shaftMountLength = outputShaftConnectionLenght + strongWall;
      cylinder(d = shaftMountDiameter, h = shaftMountLength);
      
      // wheel screws
      screwDiameter = getWheelScrewDiameter() - 0.7;
      numberOfScrews = getNumberOfWheelScrews();
      rotateCopyZ(360/numberOfScrews, numberOfScrews-1) translateX(getPitchCircleDiameter()/2)
        rotateZ(30) cylinder(d = screwDiameter, h = wheelScrewLength, $fn = 6);
    }
    
    // hole for shaft
    shaftHoleDiameter = outputShaftDiameter + 1;
    translateZ(-1) rotateZ(45)
      cylinder(d = shaftHoleDiameter, h = outputShaftConnectionLenght + 1.5, $fn = 4);
    
    // hole for wheel hub latch
    translateZ(wheelHubLatchOffset)
      cube([getRimHoleDiameter(),strongWall,wheelHubLatchSize], center = true);
    
    // holes for wheel clip
    clipHoleHeight = strongWall;
    clipHoleWidth = 2*strongWall;
    clipHoleDepth = 2*thinWall + 0.5;
    clipHoleOffsetY = getRimHoleDiameter()/2 - clipHoleDepth/2 + 0.5;
    clipHoleOffsetZ = strongWall + clipHoleHeight/2 + 2*getRimThickness();
    rotateCopyZ(120,2, center = true) translate([0,clipHoleOffsetY,clipHoleOffsetZ])
      cube([clipHoleWidth,clipHoleDepth,clipHoleHeight], center = true);
  }
}


// wheel hub latch
module wheelHubLatch()
{
  latchLength = getRimHoleDiameter() - 0.6;
  latchSize = wheelHubLatchSize - 0.6;
  latchThickness = strongWall - 0.1;
  translateX(wheelHubLatchOffset)
    cube([latchSize,latchThickness,latchLength], center = true);
}


// input gear
module inputGear()
{
  render()
  {
    difference()
    {
      union()
      {
        // basic gear
        translateY(-inputGearOffset) rotateX(-90) 
          gear(inputGearSize, gearModule, inputGearOffset/2, inputGearAngle);
        
        // end stop
        translateY(-inputGearOffset+1) rotateX(90) 
        {
          endStopLength = 2*thinWall;
          endStopDiameter = inputShaftDiameter + thinWall;
          cylinder(d = endStopDiameter, h = endStopLength+1);
          
        }
      }
      
      // hole for input shaft
      holeDiameter = inputShaftDiameter + 0.1;
      holeOffset = 2*thinWall;
      translateY(-inputGearOffset+holeOffset) rotateX(90) 
      {
        holeDepth = 2*thinWall + holeOffset;
        cylinder(d = holeDiameter, h = holeDepth+1, $fn = 4);
        
      }
    }
  }
}


// output gear
module outputGear()
{
  render() 
  {
    // basic gear
    holeDiameter = outputShaftDiameter + 0.1;
    translateX(outputGearOffset) rotateY(-90)
      gear(outputGearSize, gearModule, outputGearOffset/2, outputGearAngle, holeDiameter, 4);
    
    difference()
    {
      // gear support
      supportDiameter = holeDiameter + 2*strongWall;
      translateX(0.1) rotateY(90) 
        cylinder(d = supportDiameter, h = outputGearOffset-1);
      
      // hole for output shaft
      rotateX(45) rotateY(90)
        cylinder(d = holeDiameter, h = outputGearOffset, $fn = 4);
    }
  }
}


// input bearing 
module inputBearing()
{
  rotateX(90) difference()
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
  rotateY(90) difference()
  {
    // basic shape
    cylinder(d = outputBearingOuterDiameter, h = outputBearingWidth, center = true);
    
    // hole
    cylinder(d = outputBearingInnerDiameter, h = outputBearingWidth+1, center = true);
  }
}


// get rear axle heigth
function getRearAxleHeigth() = axleMountHeight + getWheelDiameter()/2;


// get rear axle connection offset
function getRearAxleConnectioOffset() = axleMountDistance/2;


// get rear axle mount size
function getRearAxleMountSize() = axleMountSize;

