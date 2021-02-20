// this file defines the drive shaft


// used modules
use <../../modules/copy.scad>
use <../../modules/transform.scad>


// global definitions
$fa = 5;
$fs = 0.2;


// local definitions

// shaft
inputShaftDiameter = 5;
shaftConnectionLength = inputShaftDiameter;
relativeTorque = PI/12*inputShaftDiameter^3;
shaftDiameter = (24/PI*relativeTorque)^(1/3);

// cross
pinDiameter = 2;
crossSize = 4/PI*relativeTorque/pinDiameter^2;

// yoke
yokeThickness = ceil(2*relativeTorque/shaftDiameter^2)/2;
yokeInnerDiameter = crossSize + 0.2;
yokeOuterDiameter = yokeInnerDiameter + 2*yokeThickness;
pinOffset = yokeOuterDiameter/2 + pinDiameter/2;


// shows drive shaft
driveShaft([10,150,20]);


// assembled drive shaft
module driveShaft(v)
{
  x = v[0];
  y = v[1] - pinOffset;
  z = v[2];
  
  rotZ = -atan(x/y);
  y2 = sqrt(x^2 + y^2);
  rotX = atan(z/y2);
  length = sqrt(y2^2 + z^2);
  
  rotateZ(rotZ) rotateX(rotX)
  {
    // shaft
    shaft(length);
    
    // crosses
    rotateCopyZ(180) translateY(length/2) rotateZ(-rotZ) cross();
  }
  
  // end yokes
  translate(-[x/2,y/2,z/2]) endYoke();
  translate([x/2,y/2,z/2]) rotateZ(180) endYoke();
}


// shaft
module shaft(length)
{
  // basic yokes
  mirrorCopyY() translateY(length/2) rotateY(90) yoke();
  
  // shaft
  shaftLength = length - 2*pinOffset + 2*yokeThickness;
  rotateX(90) cylinder(d = shaftDiameter, h = shaftLength, center = true);
}


// output yoke
module endYoke()
{
  // basic yoke
  yoke();
  
  // output shaft
  rotateX(90) translateZ(pinOffset) difference()
  {
    // basic shaft
    shaftLength = shaftConnectionLength+yokeThickness;
    translateZ(-yokeThickness) cylinder(d = shaftDiameter, h = shaftLength);
    
    // hole for rear axle shaft
    holeDiameter = inputShaftDiameter + 0.2;
    cylinder(d = holeDiameter, h = shaftLength, $fn = 4);
  }
}


// cross
module cross()
{
  // basic cross
  crossThickness = 1.5*pinDiameter;
  rotateCopyY(90)
  {
    // pin
    pinLength = crossSize + 2*yokeThickness;
    cylinder(d = pinDiameter, h = pinLength, center = true);
    
    // pin end stop
    cylinder(d = crossThickness, h = crossSize, center = true);
  }
  
  // reinforcement
  rotateX(90) cylinder(d = crossSize, h = crossThickness, center = true);
}


// yoke
module yoke()
{
  difference()
  {
    translateY(-pinDiameter/2)
    {
      // basic yoke
      difference()
      {
        // basic shape
        cylinder(d = yokeOuterDiameter, h = shaftDiameter, center = true);
        
        // hollow shape
        cylinder(d = yokeInnerDiameter, h = shaftDiameter+1, center = true);
        
        // cut half
        boxSize = yokeOuterDiameter+1;
        translateY(boxSize/2) cube(boxSize, true);
      }
      
      // round end
      roundEndOffset = (yokeInnerDiameter + yokeThickness)/2;
      mirrorCopyX() translateX(roundEndOffset) difference()
      {
        // basic shape
        rotateY(90) cylinder(d = shaftDiameter, h = yokeThickness, center = true);
        
        // cut half
        boxSize = shaftDiameter+1;
        translateY(-boxSize/2) cube(boxSize, true);
      }
    }
    
    // hole for cross pin
    holeDiameter = pinDiameter + 0.3;
    rotateY(90) cylinder(d = holeDiameter, h = yokeOuterDiameter+1, center = true);
    
    // phase to slide in cross
    phaseOffset = [-yokeInnerDiameter/2,holeDiameter/2,-shaftDiameter/2];
    phaseAngle = atan(yokeThickness / (shaftDiameter - 2*pinDiameter));
    mirrorCopyX() translate(phaseOffset) rotateZ(phaseAngle) cube(shaftDiameter);
  }
}

