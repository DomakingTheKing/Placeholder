//gets inputs
up_key=keyboard_check_pressed(vk_up);
down_key=keyboard_check_pressed(vk_down);
accept_key=keyboard_check_pressed(vk_space);

//store number of option in current menu
op_length=array_length(option[menu_level]);
show_debug_message(op_length);
//move down and up trought the menu
pos+=down_key - up_key;

if pos>=op_length{pos=0;}
if pos<0{pos=op_length-1;}

if accept_key{
	
	var _sal=menu_level;

	//using the menu
	switch(menu_level){
		case 0:
			switch(pos){
				//start game
				case 0: room_goto_next(); break;
				//settings
				case 1: menu_level=1; break;
				//quit game
				case 2: game_end(); break;
			}
			break;
		
		case 1: 
			switch(pos){
				//window size
				case 0:  break;
				//brightness
				case 1: break;
				//controls
				case 2: break;
				//back
				case 3:  menu_level=0; show_debug_message(menu_level); op_length=3; break;
			}
		break;
	}
		
	if (_sal=!menu_level){pos=0;}
}