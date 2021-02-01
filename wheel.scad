// this file defines the wheel


// used modules
use <copy.scad>


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
numberOfScrewHoles = 8;
screwHoleDiameter = 3;
rimHoleDiameter = 13;




// shows wheel
//rotateCopy([0,180,0]) 
  wheel();


// wheel
module wheel()
{
  translate([wheelWidth/2+wheelMountOffset,0,0]) rotate([0,-90,0])
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
      mirrorCopy([0,0,1]) translate([0,0,wheelWidth/4])
        cylinder(d1 = basicWheelDiameter, d2 = wheelDiameter-3*profileDepth, h = wheelWidth/4);
      
      // profile
      rotateCopy([0,0,360/numberOfProfiles],numberOfProfiles-1) rotateCopy([180,0,0]) 
        translate([wheelDiameter/2-profileDepth,0,0]) rotate([0,90,0]) profile();
    }

    // hole for rim
    cylinder(d = rimDiameter+0.2, h = wheelWidth+1, center = true);
    
    // egde for rim
    mirrorCopy([0,0,1]) translate([0,0,-wheelWidth/2-0.1])
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
      translate([sign(profileOffset[0])*outerProfileDiameter,0,0]) 
        cube(2*outerProfileDiameter, center = true);
      translate([0,sign(profileOffset[1])*outerProfileDiameter,0]) 
        cube(2*outerProfileDiameter, center = true);
    }
    
    // interrupt profile
    profileGap = profileWidth/2;
    profileSize = profileWidth + 2*profileDepth;
    rotate([0,0,profileAngle]) translateCopy([-profileSize,0,0]) 
      cube([profileGap,2*profileSize,2*profileSize], center = true);
    
    // remove unused parts
    profileCutOffOffset = (outerProfileDiameter+wheelWidth)/2;
    translate([-profileCutOffOffset,0,0]) cube(outerProfileDiameter, center = true);
    translate([outerProfileDiameter/2,0,0]) cube(outerProfileDiameter, center = true);
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
      mirrorCopy([0,0,1]) translate([0,0,-wheelWidth/2])
        cylinder(d1 = outerRimDiameter, d2 = innerRimDiameter, h = 2*rimThickness);
    }

    // hollow rim
    cylinder(d = innerRimDiameter, h = wheelWidth+1, center = true);
      
    // smooth edge
    mirrorCopy([0,0,1]) translate([0,0,-wheelWidth/2-rimThickness])
      cylinder(d1 = outerRimDiameter, d2 = innerRimDiameter, h = 2*rimThickness);
  }
  
  // wheel mount
  wheelMountHeight = pitchCircleDiameter - rimHoleDiameter;
  wheelMountOffset = wheelMountHeight - wheelMountOffset;
  translate([0,0,wheelWidth/2 - wheelMountOffset]) difference()
  {
    // basic wheel mount
    wheelHubDiameter = 2*pitchCircleDiameter - rimHoleDiameter;
    cylinder(d1 = rimDiameter, d2 = wheelHubDiameter,h = wheelMountHeight);
    
    // shape wheel mount
    translate([0,0,-rimThickness]) 
      cylinder(d1 = rimDiameter, d2 = wheelHubDiameter-rimThickness,h = wheelMountHeight);
    
    // rim hole 
    cylinder(d = rimHoleDiameter,h = wheelMountHeight+1);
    
    // screw holes
    rotateCopy([0,0,360/numberOfScrewHoles], numberOfScrewHoles-1)
      translate([pitchCircleDiameter/2,0,0]) rotate([0,0,30])
        cylinder(d = screwHoleDiameter, h = wheelMountHeight+1, $fn = 6);
  }
}