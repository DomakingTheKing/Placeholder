if timer >= 0 {timer --;} //2secondi
	else {image_speed=0; 
			sprite_index=spadaNoColli;}

if (keyboard_check_pressed(vk_lshift)){
	timer=30;
	sprite_index=spada;
	image_speed=1;
}
