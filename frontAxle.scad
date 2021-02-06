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

// wheel hub
outputShaftConnectionLenght = 5;
outputShaftDiameter = 5;
wheelHubLatchSize = 3;
wheelHubLatchOffset = wheelHubLatchSize/2 + strongWall;


// shows front axle
frontAxle();


// assembled front axle
module frontAxle(width = 140)
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
      wheelOffset = width/2;
      translateX(-wheelOffset)
      {
        wheel();
      }
      
      // wheel hubs
      translateX(wheelOffset - getRimThickness() - strongWall) wheelHub();
    }
    
    // steering rod
    translate([0,27,4.6]) steeringRod();
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
      clipHoleOffsetZ = strongWall + clipHoleHeight/2 + getRimThickness();
      rotateCopyZ(120,2, center = true) translate([0,clipHoleOffsetY,clipHoleOffsetZ])
        cube([clipHoleWidth,clipHoleDepth,clipHoleHeight], center = true);
    }
}











