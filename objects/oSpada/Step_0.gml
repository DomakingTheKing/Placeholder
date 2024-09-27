lato=oPlayer.face;
if lato==1 && image_speed==1{
	sprite_index=sSpadaDx
	x=oPlayer.x;
	y=oPlayer.y-20;
}else{
	if (image_speed==1){	
		sprite_index=sSpadaSx	
		x=oPlayer.x-20;
		y=oPlayer.y-20;
	}
}

if timer >= 0 {timer --;} //2secondi
	else {image_speed=0; 
			sprite_index=spadaNoColli;}

if (keyboard_check_pressed(vk_lshift)){
	timer=30;
	sprite_index=spada;
	image_speed=1;
}