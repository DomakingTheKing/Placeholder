//Exit if there is no player
if !instance_exists(oPlayer) exit;

//Get camera size and apply zoom
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

//Get camera target coords
var _camX = oPlayer.x - _camWidth/2;
var _camY = oPlayer.y - _camHeight/2;

//Constrain cam to room borders
_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

//Set cam coords at start of room
finalCamX = _camX;
finalCamY = _camY;
