//get inputs
up_key=keyboard_check_pressed(vk_up);
down_key=keyboard_check_pressed(vk_down);

//move trought the menu
pos += down_key-up_key;
if pos>=option.op_length{pos=0;}
if pos<0{pos=option.op_length-1;}