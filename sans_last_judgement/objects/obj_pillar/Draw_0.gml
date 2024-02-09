/// @desc

for (var i = 0; i < 6; ++i) {
	var stupid = 3;
	if i > stupid {
		draw_sprite(sprite_index,0,x-(camera_get_view_x(obj_camera.camera)*1.2)+((280*3)+(240*(i-3))),y);  
	}else{
		draw_sprite(sprite_index,0,x-(camera_get_view_x(obj_camera.camera)*1.2)+(280*i),y);  
	}
}

