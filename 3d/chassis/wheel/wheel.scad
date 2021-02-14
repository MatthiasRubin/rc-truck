// this file defines the wheel


// used modules
use <../../modules/copy.scad>
use <../../modules/transform.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// wheel
wheelDiameter = 60;
wheelWidth = 17.5;
wheelMountOffset = 1.5;

// profile
profileDepth = 1;
profileWidth = 3;
profileRadius = wheelDiameter/3;
profileAngle = 30;
numberOfProfiles = 36;

// rim
rimDiameter = 32;
rimThickness = 1;
innerRimDiameter = rimDiameter-2*rimThickness;
outerRimDiameter = rimDiameter+rimThickness;
pitchCircleDiameter = 18;
numberOfScrews = 8;
screwHoleDiameter = 3;
rimHoleDiameter = 13;

// wheel clip
strongWall = 1.5;

// shows wheel
//rotateCopyY(180)
  wheel();

wheelClip();


// wheel
module wheel()
{
  translateX(wheelWidth/2+wheelMountOffset) rotateY(-90)
  {
    // rim
    rim();
    
    // tire
    tire();
  }
}


// tire
module tire()
{
  difference()
  {
    union()
    {
      // basic wheel
      basicWheelDiameter = wheelDiameter-2*profileDepth;
      
      cylinder(d = basicWheelDiameter, h = wheelWidth/2, center = true);
      
      // shape wheel
      mirrorCopyZ() translateZ(wheelWidth/4)
        cylinder(d1 = basicWheelDiameter, d2 = wheelDiameter-3*profileDepth, h = wheelWidth/4);
      
      // profile
      rotateCopyZ(360/numberOfProfiles,numberOfProfiles-1) rotateCopyX(180) 
        translateX(wheelDiameter/2-profileDepth) rotateY(90) profile();
    }

    // hole for rim
    cylinder(d = rimDiameter+0.2, h = wheelWidth+1, center = true);
    
    // egde for rim
    mirrorCopyZ() translateZ(-wheelWidth/2-0.1)
      cylinder(d1 = outerRimDiameter+0.2, d2 = innerRimDiameter+0.2, h = 2*rimThickness);
  }
}

// profile shape
module profile()
{
  render() difference()
  {
    outerProfileDiameter = 2*profileRadius + profileWidth;
    profileOffset = profileRadius * [sin(-profileAngle)+0.007,cos(-profileAngle),0];
    
    translate(profileOffset) difference()
    {
      // basic profile
      cylinder(d1 = outerProfileDiameter+profileDepth, 
        d2 = outerProfileDiameter, h = 2*profileDepth, center = true);
      
      // shape basic profile
      innerProfileDiameter = 2*profileRadius - profileWidth;
      cylinder(d1 = innerProfileDiameter-profileDepth, 
        d2 = innerProfileDiameter, h = 2*profileDepth+1, center = true);
      
      // remove unused parts
      translateX(sign(profileOffset[0])*outerProfileDiameter) 
        cube(2*outerProfileDiameter, center = true);
      translateY(sign(profileOffset[1])*outerProfileDiameter) 
        cube(2*outerProfileDiameter, center = true);
    }
    
    // interrupt profile
    profileGap = profileWidth/2;
    profileSize = profileWidth + 2*profileDepth;
    rotateZ(profileAngle) translateCopyX(-profileSize) 
      cube([profileGap,2*profileSize,2*profileSize], center = true);
    
    // remove unused parts
    profileCutOffOffset = (outerProfileDiameter+wheelWidth)/2;
    translateX(-profileCutOffOffset) cube(outerProfileDiameter, center = true);
    translateX(outerProfileDiameter/2) cube(outerProfileDiameter, center = true);
  }
}


// rim
module rim()
{
  difference()
  {
    union()
    {
      // basic rim
      cylinder(d = rimDiameter,h = wheelWidth, center = true);
      
      // rim edge
      mirrorCopyZ() translateZ(-wheelWidth/2)
        cylinder(d1 = outerRimDiameter, d2 = innerRimDiameter, h = 2*rimThickness);
    }

    // hollow rim
    cylinder(d = innerRimDiameter, h = wheelWidth+1, center = true);
      
    // smooth edge
    mirrorCopyZ() translateZ(-wheelWidth/2-rimThickness)
      cylinder(d1 = outerRimDiameter, d2 = innerRimDiameter, h = 2*rimThickness);
  }
  
  // wheel mount
  wheelMountHeight = pitchCircleDiameter - rimHoleDiameter;
  wheelMountOffset = wheelMountHeight - wheelMountOffset;
  translateZ(wheelWidth/2 - wheelMountOffset) difference()
  {
    // basic wheel mount
    wheelHubDiameter = 2*pitchCircleDiameter - rimHoleDiameter;
    cylinder(d1 = rimDiameter, d2 = wheelHubDiameter,h = wheelMountHeight);
    
    // shape wheel mount
    translateZ(-rimThickness) 
      cylinder(d1 = rimDiameter, d2 = wheelHubDiameter-rimThickness,h = wheelMountHeight);
    
    // rim hole 
    cylinder(d = rimHoleDiameter,h = wheelMountHeight+1);
    
    // screw holes
    rotateCopyZ(360/numberOfScrews, numberOfScrews-1)
      translateX(pitchCircleDiameter/2) rotateZ(30)
        cylinder(d = screwHoleDiameter, h = wheelMountHeight+1, $fn = 6);
  }
}


// wheel clip
module wheelClip()
{
  rotateY(90) translateZ(rimThickness)
  {
    clipHoleDiameter = rimHoleDiameter - 0.5;
    difference()
    {
      // basic clip
      clipDiameter = clipHoleDiameter + strongWall;
      clipHeight = 2*profileDepth;
      cylinder(d = clipDiameter, h = clipHeight);
      
      // hollow clip
      clipHoleDepth = 2*clipHeight+1;
      cylinder(d = clipHoleDiameter, h = clipHoleDepth, center = true);
      
      // clip gap
      clipGapOffset = clipDiameter/2;
      translateY(-clipGapOffset) 
        cube([strongWall,clipDiameter,clipHoleDepth], center = true);
    }
    
    // clip pins
    clipPinHeight = strongWall - 0.2;
    clipPinDepth = strongWall;
    clipPinWidth = 2*profileDepth;
    clipPinOffsetY = clipHoleDiameter/2 - clipPinDepth/2 + 0.2;
    clipPinOffsetZ = clipPinHeight/2;
    rotationAngle = 120 * rimHoleDiameter / clipHoleDiameter;
    rotateCopyZ(rotationAngle,2, center = true) translate([0,clipPinOffsetY,clipPinOffsetZ])
      cube([clipPinWidth,clipPinDepth,clipPinHeight], center = true);
  }
}


// get total wheel diameter
function getWheelDiameter() = wheelDiameter;


// get total wheel width
function getWheelWidth() = wheelWidth + wheelMountOffset;


// get total rim thickness
function getRimThickness() = rimThickness;


// get pitch hole diameter
function getPitchCircleDiameter() = pitchCircleDiameter;


// get number of wheel screws
function getNumberOfWheelScrews() = numberOfScrews;


// get wheel screw hole diameter
function getWheelScrewDiameter() = screwHoleDiameter;


// get rim hole diameter
function getRimHoleDiameter() = rimHoleDiameter;






