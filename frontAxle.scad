// this file defines the front axle


// used modules
use <copy.scad>
use <transform.scad>


// used parts
use <wheel.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// wall thickness
thinWall = 1;
strongWall = 1.5;

// wheel hub latch
wheelHubLatchSize = 3;

// wheel hub
wheelHubEndStopLength = thinWall + 0.5;
wheelHubLatchOffset = wheelHubLatchSize/2 + strongWall + wheelHubEndStopLength;
shaftConnectionLenght = wheelHubEndStopLength + 2*strongWall + wheelHubLatchSize;
wheelHubDepth = shaftConnectionLenght;

// shaft
shaftDiameter = 5;

// bearings
bearingOuterDiameter = 8.5;
bearingInnerDiameter = 5;
bearingWidth = 4;


// shows front axle
frontAxle();


// assembled front axle
module frontAxle(width = 140)
{
  translateZ(-12.5)
  {
    // axle beam
    //axleBeamTop();
    //axleBeamBottom();
    
    // steering knuckles
    //translateX(42.5) steeringKnuckle();
    //translateX(-42.5) doubleSteeringKnuckle();
    
    rotateCopyY(180)
    {
      // wheel hubs
      wheelHubOffset = width/2 - wheelHubDepth;
      translateX(wheelHubOffset) 
      {
        wheelHub();
        wheelHubLatch();
      }
      
      // bearings
      bearingOffset = wheelHubOffset - bearingWidth/2 - 0.1;
      translateX(bearingOffset) rotateZ(90) bearing();
      
      // shafts
      shaftOffset = wheelHubOffset - bearingWidth - 0.2;
      translateX(shaftOffset) shaft();
      
      // wheels
      wheelOffset = wheelHubOffset + wheelHubEndStopLength + strongWall + getRimThickness();
      translateX(-wheelOffset)
      {
        wheel();
      }
    }
    
    // steering rod
    //translate([0,27,4.6]) steeringRod();
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
module doubleSteeringKnuckle()
{
  
}


// steering knuckle
module steeringKnuckle()
{

}


// steering track rod
module steeringRod()
{

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
      cylinder(d = wheelHubDiameter, h = strongWall);
      
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
    clipHoleOffsetZ = wheelHubEndStopLength + strongWall + clipHoleHeight/2 + getRimThickness();
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











