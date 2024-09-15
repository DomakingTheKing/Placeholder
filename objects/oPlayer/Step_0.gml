//Get input
rightKey = keyboard_check(vk_right) || keyboard_check(ord("D"));
leftKey = keyboard_check(vk_left) || keyboard_check(ord("A"));
jumpKey = keyboard_check(vk_space);
jumpKeyPressed = keyboard_check_pressed(vk_space);
jumpKeyReleased = keyboard_check_released(vk_space);

//X Movement
    //Direction
    moveDir = rightKey - leftKey;

    //Get xSpd
    xSpd = moveDir * moveSpd;

    //X Collisions
    var _subPixel = .5; //How close the player can get to something tangible

    if place_meeting(x + xSpd, y, oWall)
    {
        //Scoot up to wall precisely
        var _pixelCheck = _subPixel * sign(xSpd);
        while !place_meeting(x + _pixelCheck, y, oWall)
        {
            x += _pixelCheck;
        }
    
        //Set xSpd to zero to "collide"
        xSpd = 0;
    }

    //Move
    x += xSpd;

//Y Movement
    //Gravity
    ySpd += grav;

    //Cap falling speed
    if ySpd > termVel { ySpd = termVel; };

    //Jump
    if jumpKeyPressed && place_meeting(x, y+1, oWall)
    {
        ySpd = jSpd;
        jumpTime = 0; // Initialize jump time
    }

    // Variable jump height
    if jumpKey && ySpd < 0
    {
        jumpTime += 1;
        if jumpTime < maxJumpTime
        {
            ySpd = jSpd;
        }
    }

    if jumpKeyReleased && ySpd < 0
    {
        ySpd = min(ySpd, 0); // Stop upward movement only if the player is still moving upwards
    }

    //Y Collisions
    var _subPixel = .5;
    if place_meeting(x, y + ySpd, oWall)
    {
        //Scoot up to wall precisely
        var _pixelCheck = _subPixel * sign(ySpd);
        while !place_meeting(x, y + _pixelCheck, oWall)
        {
            y += _pixelCheck;
        }
    
        //Set ySpd to zero to "collide"
        ySpd = 0;
    }
    
    //Move
    y += ySpd;
