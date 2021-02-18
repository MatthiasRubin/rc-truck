// this file defines the assembled front section


// used modules
use <../../modules/transform.scad>
use <../../modules/copy.scad>


// used parts
use <../frame/frame.scad>
use <suspension/suspension.scad>
use <frontAxle/frontAxle.scad>
use <motor.scad>
use <servo.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// local definitions

// walls
strongWall = 3;

// frame
frameLength = 100;

// screws
screwHoleDiameter = 3.5;
oblongHoleLenght = screwHoleDiameter + 5;


// shows front section
frontSection();


// assembled front section
module frontSection(frameHeight = 55)
{
  translateZ(getFrontAxleHeigth())
  {
    // frame 
    axleMountFrame(frameHeight);
    
    // suspension
    suspension();
    
    // axle
    frontAxle();
  }
  
    
  translate([-7,-16.8,50]) rotateZ(180) motor();
  translate([11,-20,53]) rotateX(180) servo();
  
  // battery
  translate([0,9.3,85]) cube([56,29,50], center = true);
}


// axle mount frame
module axleMountFrame(frameHeight)
{
  // basic frame
  frameOffset = frameHeight - getFrontAxleHeigth();
  translateZ(frameOffset) rotateX(180) frame(frameLength, false);
  
  // suspension mount
  mirrorCopyX() difference()
  {
    suspensionWidth = getSupspensionInterfaceWidth();
    suspensionPosition = getSuspensionInterfaceOffset() - [suspensionWidth/2,0,0];
    suspensionOffset = frameOffset - suspensionPosition[2];
    oblongHoleShortLength = oblongHoleLenght - screwHoleDiameter;
    
    union()
    {
      // basic mount
      mountHeight = suspensionOffset + getFrameHeight()/2;
      mountWidth = 2*suspensionWidth;
      mountLenght = screwHoleDiameter + 2*strongWall;
      mountPosition = suspensionPosition + [0,0,mountHeight/2];
      translate(mountPosition) cube([mountWidth,mountLenght,mountHeight], center = true);
      
      // rounding
      translate(suspensionPosition) rotateY(90) 
        cylinder(d = mountLenght, h = mountWidth, center = true);
      
      mirrorY() 
      {
        // long mount
        longMountLength = oblongHoleLenght + 2*strongWall;;
        translate(mountPosition) cube([mountWidth,longMountLength,mountHeight], center = true);
      
        // rounding
        translate(suspensionPosition) rotateY(90)
        {
          // roundings
          mirrorCopyY() translateY(oblongHoleShortLength/2) 
            cylinder(d = mountLenght, h = mountWidth, center = true);
          
          // center part
          cube([mountLenght,oblongHoleShortLength,mountWidth], center = true);
        }
      }
    }
    
    // remove unused part
    boxHeight = 2*suspensionOffset - getFrameHeight();
    boxWidth = suspensionWidth+1;
    boxPosition = [suspensionPosition[0]+boxWidth/2,0,suspensionPosition[2]];
    translate(boxPosition) cube([boxWidth,frameLength,boxHeight], center = true);
    
    // hole to fix suspension
    holeDepth = 2*suspensionWidth+1;
    translate(suspensionPosition) rotateY(90) 
      cylinder(d = screwHoleDiameter, h = holeDepth, center = true);
    
    // oblong hole to guide suspension
    mirrorY() translate(suspensionPosition) rotateY(90)
    {
      // roundings
      mirrorCopyY() translateY(oblongHoleShortLength/2) 
        cylinder(d = screwHoleDiameter, h = holeDepth, center = true);

      // center part
      cube([screwHoleDiameter,oblongHoleShortLength,holeDepth], center = true);
    }
  }
}



