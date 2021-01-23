$fn = 50;

difference()
{
  union()
  {
    cylinder(d = 7, h = 12);
    translate([0,0,12]) cylinder(d1 = 7, d2 = 10, h = 4);
    translate([0,0,16]) cylinder(d = 10, h = 14);
  }
  
  translate([0,0,-1]) cylinder(d = 4.2, h = 6, $fn = 4);
  translate([0.7,0.7,20]) cylinder(d = 4*sqrt(2), h = 21, $fn = 4);
  translate([-0.7,-0.7,20]) cylinder(d = 4*sqrt(2), h = 21, $fn = 4);
  
  
}

