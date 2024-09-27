if place_meeting(x,y,oSpada){
 pv-=1;
}

if (image_index>=2 && attacked == false){

attacked = true;

var granade = instance_create_layer(x,y-15,layer,oBombe)
	granade.speed = random_range(4,5);
	granade.direction=random_range(0,360);
	
	granade.gravity=0.3;
	granade.gravity_direction=270;

}

if pv<=0{
	instance_destroy();
	oVittoria.nemici=oVittoria.nemici-1;
}
