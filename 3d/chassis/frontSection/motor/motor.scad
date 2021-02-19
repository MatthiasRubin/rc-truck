// this file defines the motor


// used modules
use <../../../modules/copy.scad>
use <../../../modules/transform.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// motor
motorLength = 28;
motorOffset = 0.7;

// motor fixing
fixingSize = [5,22.5,3];
fixingOffset = 43;

// gear box
gearBoxSize = [22.5,18.8,37];
gearBoxKnopOffset = 22.5;
gearBoxKnopDiameter = 4;
gearBoxKnopSize = 2;

// motor mount
mountSize = [5,3,10];
mountHole = 3;
mountHoleOffset = 31.5;
mountHoleDistance = 17.5;

// shaft
shaftOffset = 11.2;
shaftDiameter = 5.3;
shaftLength = 36.3;
shaftPhaseSize = 3.7;


// shows motor
motor();


// motor
module motor()
{
  translateZ(-shaftOffset) difference()
  {
    union()
    {
      // motor
      translate([0,motorOffset,gearBoxSize[2]]) difference()
      {
        // basic motor
        cylinder(d = gearBoxSize[0], h = motorLength);
        
        // flat motor
        boxSize = motorLength+1;
        flatOffset = boxSize/2 + gearBoxSize[1]/2 - motorOffset;
        mirrorCopyY() translate([0,flatOffset,motorLength/2]) cube(boxSize, true);
      }
      
      // motor fixing
      translate([0,motorOffset,fixingOffset]) cube(fixingSize, true);
      
      // gear box
      translateZ(gearBoxSize[2]/2) cube(gearBoxSize, true);
      
      // gear box knop
      translateZ(gearBoxKnopOffset) rotateX(90) 
        cylinder(d = gearBoxKnopDiameter , h = gearBoxSize[1]/2 + gearBoxKnopSize);
      
      // motor mount
      cube(mountSize, true);
      
      // basic motor shaft
      translateZ(shaftOffset) rotateX(90) cylinder(d = shaftDiameter, h = shaftLength, center = true);
    }
    
    // top holes to mount motor
    mirrorCopyX() translate([mountHoleDistance/2,0,mountHoleOffset]) rotateX(90) 
      cylinder(d = mountHole, h = gearBoxSize[1]+1, center = true);
    
    // bottom hole to mount motor
    translateZ(-mountSize[2]/4) rotateX(90) 
      cylinder(d = mountHole, h = mountSize[1]+1, center = true);
    
    // shaft phase
    boxLength = shaftLength - gearBoxSize[1];
    phaseOffset = gearBoxSize[1]/2 + 0.8 + boxLength/2;
    boxOffset = (shaftDiameter + shaftPhaseSize)/2;
    mirrorCopyY() translate([0,phaseOffset,shaftOffset]) mirrorCopyZ()
      translateZ(boxOffset) cube([shaftDiameter,boxLength,shaftDiameter], true);
    
  }
}


// get motor shaft offset
function getMotorShaftOffset() = shaftLength/2;