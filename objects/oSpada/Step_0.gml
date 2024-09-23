if timer >= 0 {timer --;} //2secondi
	else {image_speed=0; 
			image_index=1;}

if (keyboard_check_pressed(vk_lshift)){
	timer=50;
	image_speed=1;
}
