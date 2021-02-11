// this defines parametric gears


// used modules
use <Getriebe.scad>
use <copy.scad>
use <transform.scad>


// global defintions
$fa = 5;
$fs = 0.5;


// module definitions

// distance between teeth and edge
phase = 0.2;


// shows two spur gears
gear(12, hole = 4, holeFaces = 4);
translateX(-getSpurGearDistance(12,20)) rotateZ(180/20)
  gear(20, hole = 4, holeFaces = 4);


// shows two bevel gears
translateY(20)
{
  // calculate cone angles and offsets
  angle1 = getConeAngle(30,15);
  angle2 = getConeAngle(15,30);
  offset1 = getBevelGearOffset(30, angle1, 0.7);
  offset2 = getBevelGearOffset(15, angle2, 0.7);

  // show gears
  gear(30,0.7, h = offset1/2, coneAngle = angle1, hole = 4);
  translate([-offset2,0,offset1]) rotateY(90)
    gear(15,0.7, h = offset2/2, coneAngle = angle2, hole = 4);
}


// parametric gear

// n: number of teeth
// m: gear module (size of teeth)
// h: gear height
// coneAngle: cone angle for bevel gears
// hole: hole diameter
// holeFaces: shape of hole
module gear(n, m = 1, h = 5, coneAngle = 0, hole = 0, holeFaces = 50)
{
  difference()
  {
    union()
    {
      // basic gear
      translateZ(phase) difference()
      {
        if (coneAngle == 0)
        {
          // spur gear
          stirnrad(m, n, h - 2*phase, 0);
        }
        else
        {
          // bevel gear
          kegelrad(m, n,  coneAngle, h / cos(coneAngle), 0);
        }
        
        // remove protruding teeth at the top
        translateZ(h - 2*phase) cylinder(d = 2*n*m, h = 10*m);
      }
      
      // phase
      if (coneAngle == 0)
      {
        // spur gear phase
        cylinder(d = getInnerGearDiameter(n,m), h = h);
      }
      else 
      {
        // bottom bevel gear phase
        bottomDiameter = getInnerGearDiameter(n,m) + 2*phase*tan(coneAngle)*m;
        cylinder(d = bottomDiameter, h = phase);
        
        // top bevel gear phase
        topDiameter = bottomDiameter - 1.6*h*tan(coneAngle);
        translateZ(h - phase) cylinder(d = topDiameter, h = phase);
      }
    }
    
    if (hole != 0)
    {
      translateZ(-0.5)
      {
        // hole
        rotateZ(180/holeFaces - 90) cylinder(d = hole, h = h+1, $fn = holeFaces);
        
        // bottom hole phase
        cylinder(d = hole + 2*phase, h = phase + 0.5);
      }
      
      // top hole phase
      translateZ(h - phase) cylinder(d = hole + 2*phase, h = phase + 0.5);
    }
  }
}


// get outer diameter of a spur gear

// n: number of teeth
// m: gear module (size of teeth)
function getOuterGearDiameter(n, m = 1) = 
  let (factor = (m < 1) ? 1.1 : 1)
  m * (n + (7/3) * factor);


// get inner diameter of a spur gear

// n: number of teeth
// m: gear module (size of teeth)
function getInnerGearDiameter(n, m = 1) = 
  m * (n - 7/3);



// get distand of two spur gears

// n1: number of teeth of first gear
// n2: number of teeth of second gear
// m: gear module (size of teeth)
function getSpurGearDistance(n1, n2, m = 1) = 
  m * (n1 + n2) / 2;


// get cone angle of bevel gear

// n1: number of teeth of this gear
// n2: number of teeth of other gear
function getConeAngle(n1, n2) = 
  atan(n1/n2);


// get bevel gear offset

// n: number of teeth
// coneAngle: cone angle
// m: gear module (size of teeth)
function getBevelGearOffset(n, coneAngle = 45, m = 1) = 
  phase + m * n * cos(coneAngle - ((420*sin(coneAngle)) / (PI*n))) / (2*sin(coneAngle));



