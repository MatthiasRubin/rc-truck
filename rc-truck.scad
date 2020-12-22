// this file shows the fully assembled truck

// used parts



// shows truck
truck();


// this module is the fully assembled truck
module truck()
{
  frame();
  
  translate([50,-125,0]) wheel();
  translate([50,125,0]) wheel();
  translate([-50,-125,0]) rotate([0,180,0]) wheel();
  translate([-50,125,0]) rotate([0,180,0]) wheel();
}


module frame()
{
  translate([0,0,20]) cube([50,370,20], center = true);
}

module wheel()
{
  rotate([0,90,0]) cylinder(d = 60,h = 20);
}