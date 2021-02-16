// this file defines the truck frame


// used modules
use <../../modules/copy.scad>
use <../../modules/transform.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// frame
frameThickness = 4;
frameHeight = 10;
frameWidth = 50;
maxSectionLength = 80;

// frame support
supportThickness = 1;
supportSize = 10;

// mounting interface
holeDiameter = 3.5;
holeOffset = 10;


// shows truck frame
frame(150);


// truck frame part
module frame(length)
{
  if (length <= maxSectionLength)
  {
    // frame is short enough
    difference()
    {
      // basic frame
      cube([frameWidth,length,frameHeight], center = true);
      
      // hollow frame
      frameHoleWidth = frameWidth-2*frameThickness;
      frameHoleLength = length-2*frameThickness;
      cube([frameHoleWidth,frameHoleLength,frameHeight+1], center = true);
      
      mirrorCopyY() mirrorCopyX() 
      {
        // holes for mount frames together
        frameEndOffset = length/2-frameThickness/2;
        translate([holeOffset,frameEndOffset,0]) rotateX(90) 
          cylinder(d = holeDiameter, h = frameThickness+1, center = true);
        
        // holes on frame side
        frameSideOffset = (frameWidth-frameThickness)/2;
        translate([frameSideOffset,holeOffset,0]) rotateY(90) 
          cylinder(d = holeDiameter, h = frameThickness+1, center = true);
      }
    }
    
    // frame support
    frameEdgeOffset = [frameWidth/2,-length/2,-frameHeight/2];
    supportSize = supportSize+2*frameThickness;
    mirrorCopyY() mirrorCopyX() translate(frameEdgeOffset) rotateY(-90) 
      linear_extrude(supportSize, scale = [1,0]) square([supportThickness,supportSize]);
  }
  else
  {
    // frame is too long
    
    // split frame into several sections
    numberOfSections = ceil((length-frameThickness)/(maxSectionLength-frameThickness));
    frameOffset = (length-frameThickness)/numberOfSections;
    sectionLength = frameOffset + frameThickness;
    translateCopyY(frameOffset,numberOfSections-1, center = true) frame(sectionLength);
  }
}


// get frame width
function getFrameWidth() = frameWidth;


// get frame height
function getFrameHeight() = frameHeight;


// get frame thickness
function getFrameThickness() = frameThickness;








