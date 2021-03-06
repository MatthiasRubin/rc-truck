// this file defines the drive shaft


// used modules
use <../modules/copy.scad>
use <../modules/transform.scad>


// global definitions
$fa = 5;
$fs = 0.2;


// shows drive shaft
driveShaft();


// assembled drive shaft
module driveShaft()
{
  h = 16.9;
  l = 110.2;
  
  rotateX(-atan(h/l))
  {
    // shaft
    shaft();
    
    // crosses
    rotateCopyZ(180) translateY(55.5) cross();
  }
  
  // input yoke
  translate([0,-l/2,h/2]) inputYoke();
  
  // output yoke
  translate([0,l/2,-h/2]) outputYoke();
}


// shaft
module shaft()
{
  // basic yokes
  mirrorCopyY() translateY(55.5) rotateY(90) yoke();
  
  // shaft
  rotateX(90) cylinder(d = 8, h = 98, center = true);
}


// input yoke
module inputYoke()
{
  // basic yoke
  yoke();
  
  // input shaft
  difference()
  {
    // basic shaft
    translateY(-6) rotateX(90) cylinder(d = 8, h = 9);
    
    // hole for motor shaft
    translate([0.7,-7,0.7]) rotateX(90) cylinder(d = 4*sqrt(2), h = 9, $fn = 4);
    translate([-0.7,-7,-0.7]) rotateX(90) cylinder(d = 4*sqrt(2), h = 9, $fn = 4);
  }
}


// output yoke
module outputYoke()
{
  // basic yoke
  rotateZ(180) yoke();
  
  // output shaft
  difference()
  {
    // basic shaft
    translateY(6) rotateX(-90) cylinder(d = 8, h = 9);
    
    // hole for rear axle shaft
    translateY(7) rotateX(-90) cylinder(d = 4.2, h = 9, $fn = 4);
  }
}


// cross
module cross()
{
  // basic cross
  rotateCopyY(90)
  {
    // shaft
    cylinder(d = 2, h = 12, center = true);
    
    // shaft end stop
    cylinder(d = 3, h = 9.8, center = true);
  }
  
  // reinforcement
  rotateX(90) cylinder(d = 9.8, h = 3, center = true);
}


// yoke
module yoke()
{
  difference()
  {
    translateY(-1)
    {
      // basic yoke
      difference()
      {
        // basic shape
        cylinder(d = 14, h = 8, center = true);
        
        // hollow shape
        cylinder(d = 10, h = 9, center = true);
        
        // cut half
        translateY(7.5) cube([15,15,10], center = true);
      }
      
      // round end
      mirrorCopyX() translateX(6) difference()
      {
        // basic shape
        rotateY(90) cylinder(d = 8, h = 2, center = true);
        
        // cut half
        translateY(-2.5) cube([4,5,9], center = true);
      }
    }
    
    // hole for cross
    rotateY(90) cylinder(d = 2.3, h = 15, center = true);
    
    // phase to slide in cross
    mirrorCopyX() translate([-5,1,-1]) rotateZ(25) cube([1,4,2.3]);
  }
}

