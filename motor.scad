// this file defines the motor mount


// used modules
use <copy.scad>


// global definitions
$fa = 5;
$fs = 0.5;


// shows front wheel
motor();


// front wheel


module motor()
{
  translate([0,0,-31.8]) motorDummy();
  rotateCopy([0,0,180]) motorMount();
}

module motorMount()
{
  translate([0,15.5,0]) difference()
  {
    cube([30,12,10], center = true);
    translate([0,2.5,0]) rotate([0,90,0]) cylinder(d = 3.2, h = 35, center = true);
    mirrorCopy([1,0,0]) translate([17.5/2,-2.7,0]) rotate([90,0,0]) cylinder(d = 6, h = 10);
    translate([0,3.5,0]) cube([24,10,11], center = true);
  }
}


module motorDummy()
{
  difference()
  {
    union()
    {
      translate([0,0,18.5]) cube([22.5,18.8,37], center = true);
      
      difference()
      {
        translate([0,0,20]) cylinder(d = 22.5, h = 44.2);
        mirrorCopy([0,1,0]) translate([0,34,42]) cube([50,50,50], center = true);
      }
      
      translate([0,0,11.2]) rotate([90,0,0]) cylinder(d = 7.2, h = 37.6, center = true);
    }
    
    mirrorCopy([1,0,0]) translate([17.5/2,0,31.8]) rotate([90,0,0]) 
      cylinder(d = 3, h = 20, center = true);
    
    mirrorCopy([0,1,0]) translate([0,15.7,4.9]) cube([10,10,10], center = true);
    mirrorCopy([0,1,0]) translate([0,15.7,18.5]) cube([10,10,10], center = true);
    
  }
}

