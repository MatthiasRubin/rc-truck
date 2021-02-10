// this file defines various transform functions


// this function translates his children in x-direction

// x: translation in x direction
module translateX(x)
{
  translate([x,0,0]) children();
}

// this function translates his children in y-direction

// y: translation in y direction
module translateY(y)
{
  translate([0,y,0]) children();
}

// this function translates his children in z-direction

// z: translation in z direction
module translateZ(z)
{
  translate([0,0,z]) children();
}


// this function rotates his children around the x-axis

// x: rotation around x-axis
module rotateX(x)
{
  rotate([x,0,0]) children();
}

// this function rotates his children around the y-axis

// y: rotation around y-axis
module rotateY(y)
{
  rotate([0,y,0]) children();
}

// this function rotates his children around the z-axis

// z: rotation around z-axis
module rotateZ(z)
{
  rotate([0,0,z]) children();
}


// this function scales his children in x-direction

// x: scaling in x-direction
module scaleX(x)
{
  scale([x,0,0]) children();
}

// this function scales his children in y-direction

// y: scaling in y-direction
module scaleY(y)
{
  scale([0,y,0]) children();
}

// this function scales his children in z-direction

// z: scaling in z-direction
module scaleZ(z)
{
  scale([0,0,z]) children();
}


// this function mirrors his children in x-direction
module mirrorX()
{
  mirror([1,0,0]) children();
}

// this function mirrors his children in y-direction
module mirrorY()
{
  mirror([0,1,0]) children();
}

// this function mirrors his children in z-direction
module mirrorZ()
{
  mirror([0,0,1]) children();
}



