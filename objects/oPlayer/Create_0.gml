//Custom function for player
function setOnGround(_val = true){
	if _val == true{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	} else {
		onGround = false;
		coyoteHangTimer = 0;
	}
}




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
		//Jump values for each succesive jumps
		jumpHoldFrames[0] = 18;
		jSpd[0] = -3.15;
		jumpHoldFrames[1] = 10;
		jSpd[1] = -2.85;

	//Coyote Time
	//Hang time
	coyoteHangFrames = 2;
	coyoteHangTimer = 0;
	//Jump buffer time
	coyoteJumpFrames = 50;
	coyoteJumpTimer = 0;	