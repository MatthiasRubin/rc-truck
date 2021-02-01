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
  render() translate([wheelWidth/2+wheelMountOffset,0,0]) rotate([0,-90,0])
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
      cylinder(d = wheelDiameter-2*profileDepth, h = wheelWidth/2, center = true);
      
      // shape wheel
      mirrorCopy([0,0,1]) translate([0,0,wheelWidth/4])
        cylinder(d1 = wheelDiameter-2*profileDepth, d2 = wheelDiameter-3*profileDepth, h = wheelWidth/4);
      
      rotateCopy([0,0,10],35) rotateCopy([180,0,0]) 
        translate([wheelDiameter/2-profileDepth,0,0]) rotate([0,90,0]) profile();
    }

    // hole for rim
    cylinder(d = rimDiameter+0.2, h = wheelWidth+1, center = true);
    
    mirrorCopy([0,0,1]) translate([0,0,-wheelWidth/2-0.1])
      cylinder(d1 = outerRimDiameter+0.2, d2 = innerRimDiameter+0.2, h = 2*rimThickness);
  }
}

// profile shape
module profile()
{
  difference()
  {
    outerProfileDiameter = 2*profileRadius + profileWidth;
    innerProfileDiameter = 2*profileRadius - profileWidth;
    profileOffset = profileRadius * [sin(-profileAngle)+0.007,cos(-profileAngle),0];
    
    translate(profileOffset) difference()
    {
      cylinder(d1 = outerProfileDiameter+profileDepth, 
        d2 = outerProfileDiameter, h = 2*profileDepth, center = true);
      cylinder(d1 = innerProfileDiameter-profileDepth, 
        d2 = innerProfileDiameter, h = 2*profileDepth+1, center = true);
      translate([-50,0,0]) cube([100,200,100], center = true);
      translate([0,50,0]) cube([100,100,100], center = true);
    }
    
    rotate([0,0,profileAngle]) translateCopy([-5,0,0]) cube([1.5,10,10], center = true);
    
    translate([50,0,0]) cube([100,200,100], center = true);
    translate([-50-wheelWidth/2,0,0]) cube([100,200,100], center = true);
    
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