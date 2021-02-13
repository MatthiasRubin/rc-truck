// this file defines the assembled rear section


// used modules
use <../../modules/transform.scad>
use <../../modules/copy.scad>


// used parts
use <../frame/frame.scad>
use <../rearAxle/rearAxle.scad>


// global definitions
$fa = 5;
$fs = 0.5;
$vpd = 280;


// shows rear section
rearSection();


// assembled rear section
module rearSection()
{
  // frame 
  axleMountFrame();
  
  // axle
  rearAxle();
}


// 
module axleMountFrame()
{
  translateZ(15) 
  {
    difference()
    {
      rotateX(180) frame(80);
      rotateY(90) cylinder(d = 3.5, h = 51, center = true);
    }
  
    mirrorCopyY() translateY(11.5) cube([42,4.5,10], center = true);
  }
    
  mirrorCopyX() difference()
  {
    linear_extrude(10, scale = [1,3]) translateX(20) square(9, center = true);
    
    translateZ(3) linear_extrude(10, scale = [1,4]) translateX(18.5) square([9,6], center = true);
    
    translateX(20) cylinder(d = 3.3, h = 7, center = true);
  }
}



