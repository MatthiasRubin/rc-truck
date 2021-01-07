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


// this function copies his children and mirrors the copy

// v: mirror vector
module mirrorCopy(v = [1,0,0])
{
  children();
  mirror(v) children();
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


