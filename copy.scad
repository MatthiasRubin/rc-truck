// this file defines various copy functions


// this function copies his children and rotates the copies

// v: rotation vector
// n: number of copies
// center: rotate on both sides equally
module rotateCopy(v = [0,0,0], n = 1, center = false)
{
  // calculate rotation offset if center is true
  rotationOffset = -n*v/2;
  
  // copy rotate
  for (i = [0:n])
  {
    if (center)
    {
      rotate(i*v + rotationOffset) children();
    }
    else
    { 
      rotate(i*v) children();
    }
  }
}


// this function copies his children and rotates the copies around the x-axis

// x: around the x-axis
// n: number of copies
// center: rotate on both sides equally
module rotateCopyX(x = 0, n = 1, center = false)
{
  rotateCopy([x,0,0], n, center) children();
}


// this function copies his children and rotates the copies around the y-axis

// y: around the y-axis
// n: number of copies
// center: rotate on both sides equally
module rotateCopyY(y = 0, n = 1, center = false)
{
  rotateCopy([0,y,0], n, center) children();
}


// this function copies his children and rotates the copies around the z-axis

// z: around the z-axis
// n: number of copies
// center: rotate on both sides equally
module rotateCopyZ(z = 0, n = 1, center = false)
{
  rotateCopy([0,0,z], n, center) children();
}


// this function copies his children and translates the copies

// v: translation vector
// n: number of copies
// center: translate on both sides equally
module translateCopy(v = [0,0,0], n = 1, center = false)
{
  // calculate translation offset if center is true
  translationOffset = -n*v/2;
  
  // copy and translate
  for (i = [0:n])
  {
    if (center) 
    {
      translate(i*v + start) children();
    }
    else 
    {
      translate(i*v) children();
    }
  }
}


// this function copies his children and translates the copies in x-direction

// x: translation in x-direction
// n: number of copies
// center: translate on both sides equally
module translateCopyX(x = 0, n = 1, center = false)
{
  translateCopy([x,0,0], n, center) children();
}


// this function copies his children and translates the copies in y-direction

// y: translation in y-direction
// n: number of copies
// center: translate on both sides equally
module translateCopyY(y = 0, n = 1, center = false)
{
  translateCopy([0,y,0], n, center) children();
}


// this function copies his children and translates the copies in z-direction

// z: translation in z-direction
// n: number of copies
// center: translate on both sides equally
module translateCopyZ(z = 0, n = 1, center = false)
{
  translateCopy([0,0,z], n, center) children();
}


// this function copies his children and mirrors the copy

// v: mirror vector
module mirrorCopy(v = [1,0,0])
{
  children();
  mirror(v) children();
}


// this function copies his children and mirrors the copy in x-direction
module mirrorCopyX()
{
  mirrorCopy([1,0,0]) children();
}


// this function copies his children and mirrors the copy in y-direction
module mirrorCopyY()
{
  mirrorCopy([0,1,0]) children();
}


// this function copies his children and mirrors the copy in z-direction
module mirrorCopyZ()
{
  mirrorCopy([0,0,1]) children();
}


// this function copies his children in a grid
// translation, size and centering can be set for each dimension x,y,z

// v: translation vector
// size: size of grid
// center: translate on both sides equally
module linearGrid(v = [0,0,0], size = [1,1,1], center = [false,false,false])
{
  if (is_num(v))
  {
    // expand v to 3 dimensions
    linearGrid([v,v,v], size, center) children();
  }
  else if (is_num(size))
  {
    // expand size to 3 dimensions
    linearGrid(v, [size,size,size], center) children();
  }
  else if (is_num(center))
  {
    // expand center to 3 dimensions
    linearGrid(v, size, [center,center,center]) children();
  }
  else
  {
    translateCopy([1,0,0]*v[0], size[0]-1, center[0])
    translateCopy([0,1,0]*v[1], size[1]-1, center[1])
    translateCopy([0,0,1]*v[2], size[2]-1, center[2])
      children();
  }
}


