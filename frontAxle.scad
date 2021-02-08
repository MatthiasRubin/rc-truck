// this file defines the front axle


// used modules
use <copy.scad>
use <transform.scad>


// used parts
use <wheel.scad>


// global definitions
$fa = 5;
$fs = 0.5;
$vpd = 330;


// local definitions

// wall thickness
thinWall = 1;
strongWall = 1.5;

// steering geometry
wheelbase = 250;

// wheel hub latch
wheelHubLatchSize = 3;

// wheel hub
wheelHubEndStopLength = thinWall + 0.5;
wheelHubLatchOffset = wheelHubLatchSize/2 + thinWall + wheelHubEndStopLength;
wheelOffset = wheelHubEndStopLength + thinWall + wheelHubLatchSize + strongWall + getRimThickness();
shaftConnectionLenght = wheelOffset + thinWall;
wheelHubDepth = shaftConnectionLenght + strongWall;

// shaft
shaftDiameter = 5;

// bearing
bearingOuterDiameter = 8.5;
bearingInnerDiameter = 5;
bearingWidth = 4;

// steering knuckle
steeringPinDiameter = 3;
steeringKnuckleSize = getPitchCircleDiameter()/2 + getWheelScrewDiameter()/2;


// shows front axle
frontAxle();


// assembled front axle
module frontAxle(width = 140)
{
  translateZ(-12.5)
  {
    // local definitions
    wheelHubOffset = width/2 - wheelHubDepth;
    bearingOffset = wheelHubOffset - bearingWidth/2 - 0.1;
    
    // axle beam
    //axleBeamTop();
    //axleBeamBottom();
    
    rotateCopyZ(180)
    {
      // wheel hubs
      translateX(wheelHubOffset) 
      {
        wheelHub();
        wheelHubLatch();
      }
      
      // bearings
      translateX(bearingOffset)
      {
        rotateZ(90) bearing();
        bearingHousing();
      }
      
      // shafts
      shaftOffset = wheelHubOffset - bearingWidth - 0.2;
      translateX(shaftOffset) shaft();
      
      // wheels
      wheelOffset = wheelHubOffset + wheelOffset;
      translateX(-wheelOffset) wheel();
      
      // wheel clips
      wheelClipOffset = wheelOffset - getRimThickness();
      translateX(wheelClipOffset) wheelClip();
    }
    
    // steering knuckles
    steeringOffset = steeringKnuckleSize * bearingOffset / wheelbase;
    translateX(-bearingOffset) steeringKnuckle(steeringOffset);
    translateX(bearingOffset) doubleSteeringKnuckle(steeringOffset);
    
    // steering rod
    steeringRodLength = 2*(bearingOffset - steeringOffset);
    translateY(steeringKnuckleSize) steeringRod(steeringRodLength);
  }
}


// axle beam: top half
module axleBeamTop()
{
  
}


// axle beam: bottom half
module axleBeamBottom()
{
  
}


// basic axle beam
module basicAxleBeam()
{
  
}

// doubled steering knuckle
module doubleSteeringKnuckle(steeringOffset)
{
  // combine two steering knuckles
  mirrorX() mirrorCopyY() steeringKnuckle(steeringOffset);
}


// steering knuckle
module steeringKnuckle(steeringOffset)
{
  // basic bearing housing
  bearingHousing();
 
  difference()
  {
    steeringArmThickness = 2*thinWall;
    
    union()
    {
      // steering arm
      steeringArmLength = steeringKnuckleSize - bearingOuterDiameter/2;
      steeringArmWidth = bearingWidth/2 + thinWall;
      translate([0,bearingOuterDiameter/2,-steeringArmThickness/2]) 
        cube([steeringArmWidth,steeringArmLength,steeringArmThickness]);
      
      // steering rod joint
      translate([steeringOffset,steeringKnuckleSize,0]) 
        cylinder(r = steeringOffset, h = steeringArmThickness, center = true);
    }
     
    // hole for steering rod
    translate([steeringOffset,steeringKnuckleSize,0]) 
      cylinder(d = steeringPinDiameter, h = steeringArmThickness+1, center = true);
  }
}


// bearing housing
module bearingHousing()
{
  rotateY(90) difference()
  {
    union()
    {
      // basic housing
      housingDiameter = bearingOuterDiameter + 2*strongWall;
      housingWidth = bearingWidth/2 + thinWall;
      cylinder(d = housingDiameter, h = housingWidth);
      
      // steering pins
      pinHeight = housingDiameter + 4*strongWall;
      rotateY(90) cylinder(d = steeringPinDiameter, h = pinHeight, center = true);
    }
    
    // hole for bearing
    cylinder(d = bearingOuterDiameter, h = bearingWidth, center = true);
    
    // hole for shaft
    shaftHoleDiameter = bearingOuterDiameter - thinWall;
    sahftHoleDepth = bearingWidth + 2*thinWall + 1;
    cylinder(d = shaftHoleDiameter, h = sahftHoleDepth, center = true);
    
    // flat bottom
    boxSize = sahftHoleDepth + 4*strongWall;
    translateZ(-boxSize/2) cube(boxSize, center = true);
  }
}


// steering track rod
module steeringRod(length)
{
  steeringRodThickness = 2*thinWall;
  
  translateZ(steeringRodThickness)
  {
    // basic steering rod
    steeringRodWidth = 2*steeringRodThickness;
    cube([length,steeringRodWidth,steeringRodThickness], center = true);
    
    mirrorCopyX() translateX(length/2)
    {
      // roundings
      cylinder(d = steeringRodWidth, h = steeringRodThickness, center = true);
      
      // steering knuckle joint pins
      pinDiameter = steeringPinDiameter - 0.5;
      pinLength = 2*steeringRodThickness;
      mirrorZ() cylinder(d = pinDiameter, h = pinLength);
    }
  }
}


// shaft
module shaft()
{
  rotateY(90) translateZ(-strongWall) difference()
  {
    union()
    {
      // basic shaft
      basicShaftLength = strongWall + bearingWidth;
      cylinder(d = shaftDiameter, h = basicShaftLength);
    
      // end stop
      endStopDimeter = shaftDiameter + strongWall;
      cylinder(d = endStopDimeter, h = strongWall);
      
      // shaft connection
      shaftConnectionLenght = shaftConnectionLenght + basicShaftLength;
      rotateZ(45) cylinder(d = shaftDiameter, h = shaftConnectionLenght, $fn = 4);
    }
    
    // hole for wheel hub latch
    wheelHubLatchOffset = wheelHubLatchOffset + bearingWidth + strongWall + 0.2;
    translateZ(wheelHubLatchOffset)
      cube([getRimHoleDiameter(),strongWall,wheelHubLatchSize], center = true);
    
    // flat bottom
    boxLength = 3*(shaftConnectionLenght + bearingWidth);
    boxSize = 2*shaftDiameter;
    bottomOffset = boxSize/2 + sqrt(shaftDiameter^2 / 2)/2;
    translateX(-bottomOffset) cube([boxSize,boxSize,boxLength], center = true);
  }
}


// wheel hub
module wheelHub()
{
  rotateY(90) difference()
  {
    translateZ(wheelHubEndStopLength)
    {
      // basic wheel hub
      wheelHubDiameter = getPitchCircleDiameter() + getWheelScrewDiameter();
      wheelHubOffset = wheelHubLatchSize + thinWall;
      translateZ(wheelHubOffset) cylinder(d = wheelHubDiameter, h = strongWall);
      
      // shaft mount
      shaftMountDiameter = getRimHoleDiameter() - 0.3;
      shaftMountLength = wheelHubDepth - wheelHubEndStopLength;
      cylinder(d = shaftMountDiameter, h = shaftMountLength);
    
      // end stop
      endStopDiameter = shaftDiameter + 2*thinWall;
      translateZ(-wheelHubEndStopLength) cylinder(d = endStopDiameter, h = wheelHubEndStopLength);
    }
    
    // hole for shaft
    shaftHoleDiameter = shaftDiameter + 1;
    translateZ(-1) rotateZ(45)
      cylinder(d = shaftHoleDiameter, h = shaftConnectionLenght + 1.5, $fn = 4);
    
    // hole for wheel hub latch
    translateZ(wheelHubLatchOffset)
      cube([getRimHoleDiameter(),strongWall,wheelHubLatchSize], center = true);
    
    // holes for wheel clip
    clipHoleHeight = strongWall;
    clipHoleWidth = 2*strongWall;
    clipHoleDepth = 2*thinWall + 0.5;
    clipHoleOffsetY = getRimHoleDiameter()/2 - clipHoleDepth/2 + 0.5;
    clipHoleOffsetZ = wheelOffset + clipHoleHeight/2;
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


// wheel bearing
module bearing()
{
  rotateX(90) difference()
  {
    // basic shape
    cylinder(d = bearingOuterDiameter, h = bearingWidth, center = true);
    
    // hole
    cylinder(d = bearingInnerDiameter, h = bearingWidth+1, center = true);
  }
}











