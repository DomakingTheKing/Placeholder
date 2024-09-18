//move in a circle
dir+=rotSpd;

//get our target position
var _xTraget= xstart + lengthdir_x(radius,dir);
var _yTraget= ystart + lengthdir_y(radius,dir);

//get our spd
xSpd=_xTraget-x;
ySpd=_yTraget-y;

//move
x += xSpd;
y += ySpd;