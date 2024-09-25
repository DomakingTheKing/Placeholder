//Draw player
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*face, image_yscale, image_angle, image_blend, image_alpha);
draw_set_font(Font1);
var _c=c_white;
draw_text_color(x,y-30,pv,_c,_c,_c,_c,1);