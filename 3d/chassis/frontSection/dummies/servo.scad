// this file defines a servo dummy


// used modules
use <../../../modules/copy.scad>
use <../../../modules/transform.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// servo housing
servoSize = [12,29.6,26];
shaftHousingDiameter = 13.3;
gearHousingDiameter = 9.4;
gearHousingHeight = 4;
gearHousingOffset = 1.55;

// servo mount
servoMountSize = [servoSize[0],40.4,2];
servoMountOffset = 6;
mountHoleDiameter = 4.6;
mountHoleOffset = 18;

// shaft
shaftDiameter = 5.5;
shaftLength = 7.5;
shaftOffset = 4.8;
shaftHoleDiameter = 2;
shaftHoleDepth = 5;


// shows servo dummy
servo();


// servo dummy
module servo()
{
  difference()
  {
    shaftLength = shaftLength + servoMountOffset;
    union()
    {
      // servo housing
      servoHousingOffset = servoSize[2]/2 - servoMountOffset;
      translateZ(-servoHousingOffset) cube(servoSize, true);
      
      // servo mount
      translateZ(servoMountSize[2]/2) cube(servoMountSize, true);
       
      gearHousingHeight = gearHousingHeight + servoMountOffset;
      translateY(shaftOffset) 
      {
        // servo shaft housing
        cylinder(d = shaftHousingDiameter, h = gearHousingHeight);
        
        // servo shaft
        cylinder(d = shaftDiameter, h = shaftLength);
      }
      
      // gear housing
      translateY(-gearHousingOffset) cylinder(d = gearHousingDiameter, h = gearHousingHeight);
    }
    
    // remove material from shaft housing
    mirrorCopyX() translate([servoSize[0]/2,0,-1]) cube(shaftHousingDiameter);
    
    // hole in servo shaft
    shaftHoleOffset = shaftLength - shaftHoleDepth;
    translate([0,shaftOffset,shaftHoleOffset]) cylinder(d = 2, h = shaftHoleDepth+1);
    
    // holes to mount servo
    mountHoleDepth = 2*servoMountSize[2] + 1;
    mirrorCopyY() translateY(mountHoleOffset) 
      cylinder(d = mountHoleDiameter, h = mountHoleDepth, center = true);
  }
}

