// this file defines front axle suspension


// used modules
use <../../modules/copy.scad>
use <../../modules/transform.scad>
use <../frontAxle/frontAxle.scad>


// global definitions
$fa = 2;
$fs = 0.5;
$vpd = 280;


// local definitions

// spring leaf
numberOfLeafs = 5;
minLeafLength = 30;
maxLeafLength = 85;
leafRaduis = 150;
leafWidth = 5;
leafThickness = 1.5;
topLeafOffset = (numberOfLeafs-1)*leafThickness;
leafOffset = (getFrontAxleMountSize() - leafWidth)/2;

// screws
screwDiameter = 3;


// shows front axle suspension
suspension();
frontAxle();


// front axle suspension
module suspension()
{
  rotateCopyZ(180) translateX(getFrontAxleConnectioOffset())
  {
    // bottom spring leafs
    numberOffBottomLeafs = numberOfLeafs-1;
    maxUsableLength = maxLeafLength-screwDiameter-leafThickness;
    leafLengthStep = (maxUsableLength - minLeafLength) / numberOffBottomLeafs;
    for (i = [0:numberOffBottomLeafs-1])
    {
      leafLength = minLeafLength+leafLengthStep*i;
      leafOffset = leafThickness*i;
      translateZ(leafOffset) springLeaf(leafRaduis,leafLength);
    }
  
    // top spring leaf
    translateZ(topLeafOffset) topSpringLeaf(leafRaduis,maxLeafLength);
  }
}


// spring leaf
module topSpringLeaf(radius, length)
{
  // basic spring leaf
  springLeaf(radius, length);
  
  // suspension mount
  mirrorCopyY() translate(getSpringOffset(radius, length))
  {
    rotateY(90) difference()
    {
      // mount support
      mountDiameter = screwDiameter+2*leafThickness;
      cylinder(d = mountDiameter, h = leafWidth, center = true);
      
      // mount hole
      holeDepth = leafWidth+1;
      cylinder(d = screwDiameter, h = holeDepth, center = true);
    }
  }
}


// spring leaf
module springLeaf(radius, length)
{
  difference()
  {
    translateZ(leafThickness/2)
    {
      // basic spring leaf
      angle = getSectorAngle(radius, length);
      translate([leafOffset,0,radius]) rotateY(90) rotateZ(-angle/2) rotate_extrude(angle = angle) 
        translate([radius-leafThickness/2,-leafWidth/2]) polygon([
          [0,0],
          [0,leafWidth],
          [leafThickness-0.3,leafWidth],
          [leafThickness,leafWidth-0.5],
          [leafThickness,0]
        ]);
      
      // axle mount support
      mountSize = getFrontAxleMountSize();
      cube([mountSize,mountSize,leafThickness], center = true);
    }

    // hole to mount axle
    holeDepth = 2*leafThickness+1;
    cylinder(d = screwDiameter, h = holeDepth, center = true);
  }
}



// get sector angle

// r: sector radius
// l: arc length of sector
function getSectorAngle(r, l) = 
  (180 * l) / (PI * r);


// get sector angle

// r: sector radius
// l: arc length of sector
function getSpringOffset(r, l) = 
  let (angle = getSectorAngle(r, l))
  [leafOffset, r*sin(angle/2), r*(1 - cos(angle/2)) - screwDiameter + leafThickness];


// get suspension interface offset
function getSuspensionInterfaceOffset() = 
  getSpringOffset(leafRaduis,maxLeafLength) + [getFrontAxleConnectioOffset(),0,topLeafOffset];


// get supsension interface width
function getSupspensionInterfaceWidth() = leafWidth;
