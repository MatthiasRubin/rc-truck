// this file defines front axle suspension


// used modules
use <../modules/copy.scad>
use <../modules/transform.scad>


// used parts
use <frontAxle/frontAxle.scad>


// global definitions
$fa = 2;
$fs = 0.5;


// shows front axle suspension
suspension();
frontAxle();

mirrorCopyX() mirrorCopyY() translate(getSuspensionInterfaceOffset()) rotateY(90) 
  cylinder(d = 2.8, h = 6, center = true);


// front axle suspension
module suspension()
{

  rotateCopyZ(180) translateX(20)
  {
    for (i = [0:3])
    {
      translateZ(1.5*i) springLeaf(150,30+12*i);
    }
  
    translateZ(6) topSpringLeaf(150,85);
  }
}


// spring leaf
module topSpringLeaf(radius, length)
{
  springLeaf(radius, length);
  mirrorCopyY() translate(getSpringOffset(radius, length))
  {
    rotateY(90) difference()
    {
      cylinder(d = 6, h = 5, center = true);
      cylinder(d = 3, h = 6, center = true);
    }
  }
}


// spring leaf
module springLeaf(radius, length)
{
  difference()
  {
    translateZ(0.75)
    {
      angle = getSectorAngle(radius, length);
      translate([2,0,radius]) rotateY(90) rotateZ(-angle/2) rotate_extrude(angle = angle) 
        translateX(radius) square([1.5,5], center = true);
      
      cube([9,9,1.5], center = true);
    }

    cylinder(d = 3, h = 4, center = true);
  }
}



// get sector angle

// r: sector radius
// l: arc length of sector
function getSectorAngle (r, l) = 
  (180 * l) / (PI * r);


// get sector angle

// r: sector radius
// l: arc length of sector
function getSpringOffset (r, l) = 
  let (angle = getSectorAngle(r, l))
  [2, r*sin(angle/2), r*(1 - cos(angle/2)) - 1.5];


function getSuspensionInterfaceOffset() = 
  getSpringOffset(150,85) + [20,0,6];



