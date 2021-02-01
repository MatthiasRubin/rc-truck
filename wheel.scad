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
wheel();


// wheel
module wheel()
{
  translate([wheelWidth/2+wheelMountOffset,0,0]) rotate([0,-90,0])
  {
    // rim
    rim();
    
    // tire
    //tire();
  }
}


// tire
module tire()
{
  difference()
  {
    // basic wheel
    cylinder(d = wheelDiameter,h = wheelWidth, center = true);

    // hole for rim
    cylinder(d = rimDiameter+0.2, h = wheelWidth+1, center = true);
    
    mirrorCopy([0,0,1]) translate([0,0,-wheelWidth/2-0.1])
      cylinder(d1 = outerRimDiameter+0.2, d2 = innerRimDiameter+0.2, h = 2*rimThickness);
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
      
      
      mirrorCopy([0,0,1]) translate([0,0,-wheelWidth/2])
        cylinder(d1 = outerRimDiameter, d2 = innerRimDiameter, h = 2*rimThickness);
    }

    // shape rim
    cylinder(d = innerRimDiameter, h = wheelWidth+1, center = true);
      
    mirrorCopy([0,0,1]) translate([0,0,-wheelWidth/2-rimThickness])
      cylinder(d1 = outerRimDiameter, d2 = innerRimDiameter, h = 2*rimThickness);
  }
  
  
  wheelHubDiameter = 2*pitchCircleDiameter - rimHoleDiameter;
  wheelMountHeight = pitchCircleDiameter - rimHoleDiameter;
  wheelMountOffset = wheelMountHeight - wheelMountOffset;
  
  translate([0,0,wheelWidth/2 - wheelMountOffset]) difference()
  {
    wheelHubDiameter = 2*pitchCircleDiameter - rimHoleDiameter;
    cylinder(d1 = rimDiameter, d2 = wheelHubDiameter,h = wheelMountHeight);
    translate([0,0,-rimThickness]) 
      cylinder(d1 = rimDiameter, d2 = wheelHubDiameter-rimThickness,h = wheelMountHeight);
    cylinder(d = rimHoleDiameter,h = wheelMountHeight+1);
    
    rotateCopy([0,0,360/numberOfScrewHoles], numberOfScrewHoles-1)
      translate([pitchCircleDiameter/2,0,0]) rotate([0,0,30])
        cylinder(d = screwHoleDiameter, h = wheelMountHeight+1, $fn = 6);
  }
}