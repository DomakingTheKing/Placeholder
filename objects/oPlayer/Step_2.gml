if place_meeting(x,y,oNemico) && oNemico.image_index==0 && invulmerability == false{
 pv-=20;
 invulmerability = true;
}

if invulmerability && invulme_timer<30{invulme_timer+=1;}
else{invulmerability = false; invulme_timer=0;}


if pv<0{
	room_goto_previous();
}