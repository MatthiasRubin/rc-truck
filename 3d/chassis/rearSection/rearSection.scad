// this file defines the assembled rear section


// used modules
use <../../modules/transform.scad>
use <../../modules/copy.scad>


// used parts
use <../frame/frame.scad>
use <rearAxle/rearAxle.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// frame
frameLength = 80;


// axle mount
axleMountThickness = 3;

// screws
screwHoleDiameter = 3.2;
screwHeadDiameter = 5.5;


// shows rear section
rearSection();


// assembled rear section
module rearSection(frameHeight = 55)
{
  translateZ(getRearAxleHeigth())
  {
    // frame 
    axleMountFrame(frameHeight);
    
    // axle
    rearAxle();
  }
}


// axle mount frame
module axleMountFrame(frameHeight)
{
  // mount frame
  mountFrameHeight = frameHeight - getRearAxleHeigth();
  
  // axle mount
  axleMountHeight = mountFrameHeight - getFrameHeight()/2;
  axleMountSizeBottom = getRearAxleMountSize();
  axleMountSizeTop = 2*axleMountHeight + axleMountSizeBottom;
  
  // axle mount hole
  axleMountHoleHeight = axleMountHeight - axleMountThickness+0.01;
  axleMountHoleSizeTop = 2*axleMountHoleHeight + screwHeadDiameter;
  
  mirrorCopyX() difference()
  {
    // basic axle mount
    scaleFactor = axleMountSizeTop/axleMountSizeBottom;
    axleMountOffset = getRearAxleConnectioOffset();
    linear_extrude(axleMountHeight, scale = [1,scaleFactor]) translateX(axleMountOffset) 
      square(axleMountSizeBottom, center = true);
    
    // hollow axle mount
    scaleFactorHole = axleMountHoleSizeTop/screwHeadDiameter;
    axleMountHoleOffset = axleMountOffset - (axleMountSizeBottom - screwHeadDiameter)/2;
    translate([axleMountHoleOffset,0,axleMountThickness]) 
      linear_extrude(axleMountHoleHeight, scale = [1,scaleFactorHole])
        square([axleMountSizeBottom,screwHeadDiameter], center = true);
    
    // hole to mount axle
    holeDepth = 2*axleMountThickness+1;
    translateX(axleMountOffset) cylinder(d = screwHoleDiameter, h = holeDepth, center = true);
  }
  
  translateZ(mountFrameHeight) 
  {
    difference()
    {
      // basic frame
      rotateX(180) frame(frameLength);
      
      // central mounting hole
      holeDepth = getFrameWidth() + 1;
      rotateY(90) cylinder(d = screwHoleDiameter, h = holeDepth, center = true);
    }
  
    // axle mount support
    supportOffset = (axleMountSizeTop + axleMountHoleSizeTop)/4;
    supportThickness = (axleMountSizeTop - axleMountHoleSizeTop)/2;
    supportLength = getFrameWidth() - 2*getFrameThickness();
    mirrorCopyY() translateY(supportOffset) 
      cube([supportLength,supportThickness,getFrameHeight()], center = true);
  }
}


function getRearSectionShaftOffset() = [0,0,getRearAxleHeigth()] + getRearAxleShaftOffset();
