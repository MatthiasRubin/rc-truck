// this file defines the drive shaft


// used modules
use <copy.scad>


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
  
  rotate([-atan(h/l),0,0]) 
  {
    shaft();
    rotateCopy([0,0,180]) translate([0,55.5,0]) cross();
  }
  
  translate([0,-l/2,h/2]) inputYoke();
  translate([0,l/2,-h/2]) outputYoke();
}


// shaft
module shaft()
{
  mirrorCopy([0,1,0]) translate([0,55.5,0]) rotate([0,90,0]) yoke();
  rotate([90,0,0]) cylinder(d = 8, h = 98, center = true);
}


// input yoke
module inputYoke() 
{
  yoke();
  difference()
  {
    translate([0,-6,0]) rotate([90,0,0]) cylinder(d = 8, h = 9); 
    translate([0.7,-7,0.7]) rotate([90,0,0]) cylinder(d = 4*sqrt(2), h = 9, $fn = 4);
    translate([-0.7,-7,-0.7]) rotate([90,0,0]) cylinder(d = 4*sqrt(2), h = 9, $fn = 4);
  }
}


// output yoke
module outputYoke()
{
  rotate([0,0,180]) yoke();
  difference()
  {
    translate([0,6,0]) rotate([-90,0,0]) cylinder(d = 8, h = 9); 
    translate([0,7,0]) rotate([-90,0,0]) cylinder(d = 4.2, h = 9, $fn = 4);
  }
}


// cross
module cross()
{
  rotateCopy([0,90,0])
  {
    cylinder(d = 2, h = 12, center = true);
    cylinder(d = 3, h = 9.8, center = true);
  }
  
  rotate([90,0,0]) cylinder(d = 9.8, h = 3, center = true);
}


// yoke
module yoke()
{
  difference()
  {
    translate([0,-1,0])
    {
      difference()
      {
        cylinder(d = 14, h = 8, center = true);
        
        cylinder(d = 10, h = 9, center = true);
        
        translate([0,7.5,0]) cube([15,15,10], center = true);
      }
      
      
      mirrorCopy([1,0,0]) translate([6,0,0]) difference()
      {
        rotate([0,90,0]) cylinder(d = 8, h = 2, center = true);
        
        translate([0,-2.5,0]) cube([4,5,9], center = true);
      }
    }
    
    rotate([0,90,0]) cylinder(d = 2.3, h = 15, center = true);
    
    mirrorCopy([1,0,0]) translate([-5,1,-1]) rotate([0,0,25]) cube([1,4,2.3]);
  }
}

