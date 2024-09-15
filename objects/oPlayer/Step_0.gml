// Get input
getControls();

// X Movement
// Direction
moveDir = rightKey - leftKey;

// Get xSpd
xSpd = moveDir * moveSpd;

// X Collisions
var _subPixel = 0.5; // How close the player can get to something tangible

if (place_meeting(x + xSpd, y, oWall)) {
    // Scoot up to wall precisely
    var _pixelCheck = _subPixel * sign(xSpd);
    while (!place_meeting(x + _pixelCheck, y, oWall)) {
        x += _pixelCheck;
    }

    // Set xSpd to zero to "collide"
    xSpd = 0;
}

// Move
x += xSpd;

// Y Movement
// Gravity
ySpd += grav;

// Reset/Prepare jumping variables
if (onGround) {
    jumpCount = 0;
} else {
    if (jumpCount == 0) {
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
if (place_meeting(x, y + ySpd, oWall)) {
    // Scoot up to wall precisely
    var _pixelCheck = _subPixel * sign(ySpd);
    while (!place_meeting(x, y + _pixelCheck, oWall)) {
        y += _pixelCheck;
    }

    // Bonk code
    if (ySpd < 0) {
        jumpHoldTimer = 0;
    }

    // Set ySpd to zero to "collide"
    ySpd = 0;
}

// Set if on ground
if (ySpd >= 0 && place_meeting(x, y + 1, oWall)) {
    onGround = true;
} else {
    onGround = false;
}

// Move
y += ySpd;
