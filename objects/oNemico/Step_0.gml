if instance_place(x,y,oSpada) && oSpada.sprite_index==sSpada{
 pv-=1;
}

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
					if moveDir==1{
						moveDir=-1;
					} else{
						moveDir=1
					}
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
	
	if coyoteHangTimer > 0{
		//Count the time down
		coyoteHangTimer--;
	} else {
		//Apply gravity to the player
		ySpd += grav;
		//We're no longer on the ground
		setOnGround(false);
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

	//do the actual check and add object to the list
	var _listSize=instance_place_list(x, y+1 + _clampYSpd + movePlatMaxYSped ,_array, _list, false);

	//loop trought the cooliding instance and only return one if it's top is below of player 
	for(var i=0; i<_listSize; i++){
	
		//get an istance of wall or a semisolid Wall
		var _listInst=ds_list_find_value(_list,i);

		//avoid magnetism
		if (_listInst.ySpd <= ySpd || instance_exists(myFloorePlatform))
		&& (_listInst.ySpd>0 || place_meeting(x,y+1+_clampYSpd,_listInst)){
			//return a solid wall or any semisolid walls that are below the player
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
		//make sure we don't end up below the top of a semisolid
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
	
if pv<=0{
	image_index=1;
	 moveDir=0;
}
