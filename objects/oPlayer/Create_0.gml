//Controls setup
controlsSetup();

//Moving
moveDir = 0; // 0 = still, -1 = sx, 1 = dx
moveSpd = 3;
xSpd = 0;
ySpd = 0;

//Jumping
grav = .275; // .275 pixels per frame
termVel = 5; // acceleration cap
onGround = true;
jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;

jumpHoldFrames[0] = 18;
jSpd[0] = -3.15;
jumpHoldFrames[1] = 10;
jSpd[1] = -2.85;

