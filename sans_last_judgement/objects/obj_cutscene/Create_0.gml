/// @desc
cut = cutscene_create();
with(obj_player){
		image_index = 0;
		image_speed = 0;
	}


scene_func(function(){
	set_pause(true);
	with(obj_player){
		image_index = 0;
		image_speed = 0;
		input = false;
	}
})
//scene_wait(60*2);
scene_func(function(){
	with(obj_player){
		image_index = 0;
		image_speed = 0;
	}
	obj_camera.mode = "cutscene";
	obj_cam_follow.follow_pl = false;
	do_anime(obj_cam_follow.x,obj_cam_follow.x+130,60,"linear", function(a) { obj_cam_follow.x = a;});
})

scene_wait(70);

scene_dialog("sans_dio");
scene_func(function(){
	with(obj_player){
		image_index = 0;
		image_speed = 1;
	}
});
scene_move_speed(obj_player,obj_player.x+20,obj_player.y,1);
scene_func(function(){
	with(obj_player){
		image_index = 0;
		image_speed = 0;
	}
});

scene_dialog("sans_dio2");
scene_func(function(){
	obj_sans.image_xscale = -1;
	obj_sans.image_speed = 1;
})
scene_move_speed(obj_sans,obj_sans.x+100,obj_sans.y,1);
scene_func(function(){
	instance_destroy(obj_sans);
	room_fade(room_credits);
})
scene_wait(60*3);
cutscene_run();


