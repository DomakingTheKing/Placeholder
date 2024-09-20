// Get input
getControls();

// X Movement
// Direction
moveDir = rightKey - leftKey;

// Get xSpd
xSpd = moveDir * moveSpd;

// X Collisions
var _subPixel = .5; // How close the player can get to something tangible

if (place_meeting(x + xSpd, y, oWall)) {
    
	//Firt check if there is a slope to go up
	if !place_meeting(x + xSpd, y - abs(xSpd)-1, oWall){
	
		while (place_meeting(x + xSpd, y, oWall)) {
			y -= _subPixel;
		}
	} else
		{
		//ceiling collision
			if !place_meeting(x + xSpd, y + abs(xSpd)+1, oWall){
	
				while (place_meeting(x + xSpd, y, oWall)) {
					y += _subPixel;
				}
			}
			else{
				// Scoot up to wall precisely
				var _pixelCheck = _subPixel * sign(xSpd);
				if(!place_meeting(x + _pixelCheck, y, oWall)) {
					x += _pixelCheck;
				}

				// Set xSpd to zero to "collide"
				xSpd = 0;
			}
		}
}

//go down slopes
if ySpd >=0 && !place_meeting(x+xSpd,y+1,oWall) && place_meeting(x + xSpd, y + abs(xSpd) +1, oWall){
		while (!place_meeting(x + xSpd, y+_subPixel, oWall)) {
			y += _subPixel;
		}
}

// Move
x += xSpd;

// Y Movement
// Gravity
if coyoteHangTimer > 0{
	//Count the time down
	coyoteHangTimer--;
} else {
	//Apply gravity to the player
	ySpd += grav;
	//We're no longer on the ground
	setOnGround(false);
}



// Reset/Prepare jumping variables
if (onGround) {
    jumpCount = 0;
	coyoteJumpTimer = coyoteJumpFrames;
} else {
	//If the player is in the air, make sure they can't do an extra jump
	coyoteJumpTimer--;
    if (jumpCount == 0 && coyoteJumpTimer <= 0) {
        jumpCount = 1;
    }
}

// Initialize jump
if (jumpKeyPressed && jumpCount < jumpMax) {
    // Reset the buffer
    jumpKeyBuffered = false;
    jumpKeyBufferTimer = 0;

    // Increase performed jumps
    jumpCount++;

    // Set jump hold timer
    jumpHoldTimer = jumpHoldFrames[jumpCount - 1];
	//Tell ourself we're no longer on the ground
	setOnGround(false);
}

// Cut off the jump by releasing the jump button
if (!jumpKey) {
    jumpHoldTimer = 0;
}

// Jump based on the timer/holding the button
if (jumpHoldTimer > 0) {
    ySpd = jSpd[jumpCount - 1];

    // Count down the timer
    jumpHoldTimer--;
}

// Y Collisions and final movement
// Cap falling speed
if (ySpd > termVel) {
    ySpd = termVel;
}

var _subPixel = 0.5;

//upwors y collison
if (ySpd <= 0){ 
	if ySpd < 0 && place_meeting(x,y + ySpd, oWall){
		
		var _slopeSide=false;
		//Jump into soped ceilings
		//lide UpLeft slope
		if xSpd == 0 && !place_meeting(x - abs(ySpd)-1, y + ySpd, oWall){
			while place_meeting(x, y + ySpd, oWall){
				x -= 1;
				_slopeSide=true;
			}
			timerbo++;
		}
		
		if xSpd == 0 && !place_meeting(x + abs(ySpd)+1, y + ySpd, oWall){
			while place_meeting(x, y + ySpd, oWall){
				x += 1;
				_slopeSide=true;
			}
			timerbo++;			
		}
	
	if !_slopeSide{
	    // Scoot up to wall precisely
	    var _pixelCheck = _subPixel * sign(ySpd);
	    while (!place_meeting(x, y + _pixelCheck, oWall)) {
	        y += _pixelCheck;
	    }


	}
			    //Bonk code(OPTIONAL)
	    if (ySpd < 0) {
	       jumpHoldTimer = 0;
	    }

	    // Set ySpd to zero to "collide"
	    ySpd = 0;
  }
}

//Floor y collison

var _clampYSpd = max(0 , ySpd);
var _list = ds_list_create() //	create a DS list to store all the object we run into
var _array=array_create(0);
array_push(_array, oWall, oSemiSolidWall);

//do the actual check e add object to the list
var _listSize=instance_place_list(x, y+1 + _clampYSpd + movePlatMaxYSped ,_array, _list, false);

//loop trought the cooliding istance  and only return one if it's top is below of player 
for(var i=0; i<_listSize; i++){
	
	//get an istance of wall ora semisolid Wall
	var _listInst=ds_list_find_value(_list,i);

	//avoid magnetism
	if (_listInst.ySpd <= ySpd || instance_exists(myFloorePlatform))
	&& (_listInst.ySpd>0 || place_meeting(x,y+1+_clampYSpd,_listInst)){
		//return a solid wall o any semisold walls there are below the player
		if _listInst.object_index==oWall
		|| object_is_ancestor(_listInst.object_index, oWall)
		|| floor(bbox_bottom)<=ceil(_listInst.bbox_top-_listInst.ySpd){
		
			//Return the "highest wall object"
			if !instance_exists(myFloorePlatform)
			|| _listInst.bbox_top + _listInst.ySpd <= myFloorePlatform.bbox_top + myFloorePlatform.ySpd
			|| _listInst.bbox_top + _listInst.ySpd <= bbox_bottom{
		
				myFloorePlatform=_listInst;		
			}
		}
	}
}
//Destroy the DS list to avoid a memory leak
ds_list_destroy(_list);

//One last check to make sure the floor platform is actually below us
if instance_exists(myFloorePlatform) && !place_meeting(x,y+movePlatMaxYSped,myFloorePlatform){
	myFloorePlatform=noone;
}

//land on the ground platform if there is one
if instance_exists(myFloorePlatform){
	
	//Scoot up to our wall precisely
	var _subPixel = .5;
	while !place_meeting(x,y+_subPixel,myFloorePlatform) && !place_meeting(x,y,oWall){
		y += _subPixel;
	}
	//make sure we don?t end up below the top of a semisolid
	if myFloorePlatform.object_index == oSemiSolidWall || object_is_ancestor(myFloorePlatform.object_index, oSemiSolidWall){
		while place_meeting(x,y,myFloorePlatform){
			y -= _subPixel;
		}	
	}
	//Floor the y variables
	y = floor(y);
	
	//Collide with the ground
	ySpd=0;
	setOnGround(true);
}

// Move
y += ySpd;

// final moving platform collision e movment


//X movePlatXSpd and collision
//Move whit move plat xSpd


movePlatXSpd=0;
if instance_exists(myFloorePlatform){ movePlatXSpd = myFloorePlatform.xSpd;}

if place_meeting(x+movePlatXSpd,y,oWall){
				
				var _pixelCheck=.5;
				var _pixelCheck = _subPixel * sign(movePlatXSpd);
				
				while(!place_meeting(x + _pixelCheck, y, oWall)) {
					x += _pixelCheck;
				}

				movePlatXSpd=0;
}

x += movePlatXSpd;



	//Y - snap my floor to myFloorePlatform
if instance_exists(myFloorePlatform)
&& (myFloorePlatform.ySpd != 0
|| myFloorePlatform.object_index == oSemiSolidMovePlat
|| object_is_ancestor(myFloorePlatform.object_index, oSemiSolidMovePlat)){

	//Snap to the top of the platform (un-floor our y variabile so it's not chopp)
	if !place_meeting(x, myFloorePlatform.bbox_top, oWall)
	&& myFloorePlatform.bbox_top >= bbox_bottom-movePlatMaxYSped{
	
		y=myFloorePlatform.bbox_top
		
	}

}


	
	
	
	
	
	
	
	
	
	
	
	