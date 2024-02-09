randomize();
global.dt = 1 / game_get_speed(gamespeed_fps);

#region window
//remember to set the size of rm_init to the scaled dimensions
//otherwise the screen may look weird for a second
global.camWidth = 320;
global.camHeight = 240;
global.camScale =  game_get_max_scale(global.camWidth * 2, global.camHeight * 2);
//global.camScale = 2; //TODO: switch back
game_set_resolution(global.camWidth, global.camHeight, global.camScale);
#endregion

lang_set_newline("\\n");
lang_set_directory("english");
lang_file_load("object_interactions.txt");

#region overworld sprite maps
var map = char_map_create();
global.charPlayer = map;
char_map_default(map, "stand");
char_map_4dir(map, "stand",	spr_frisk_u,		spr_frisk_d,
							spr_frisk_l,	spr_frisk_r);
char_map_4dir(map, "walk",	spr_frisk_u,		spr_frisk_d,
							spr_frisk_l,	spr_frisk_r);

var map = char_map_create();
global.charSans = map;
char_map_default(map, "stand");
char_map_4dir(map, "stand",	spr_sans_l,		spr_sans_l,
							spr_sans_l,	spr_sans_r);
char_map_4dir(map, "walk",	spr_sans_l,		spr_sans_l,
							spr_sans_l,	spr_sans_r);
#endregion



#region dialog and text stuff
global.fontStruct = {
	"normal" : font_dt_mono,
	"sans": font_sans
}

global.colorStruct = {
	"white" : c_white,
	"black" : c_black,
	"red" : c_red,
	"blue" : c_blue,
	"green" : c_lime
}

global.soundStruct = {
	"sans" : snd_dialog_sans,
	"harsh" : snd_dialog_harsh
}

text_set_color_struct(global.colorStruct);
text_set_font_struct(global.fontStruct);
text_set_sound_struct(global.soundStruct);
text_set_silent_chars(" /n/t");
text_add_char_delay(".,;:!?", 6);
text_set_gain(0.5);

dialog_character("jeff", sprite_2, sprite_0, snd_dialog_sans, {
	happy : sprite_1,
	happy_talk : sprite_0,
	normal : sprite_2,
	normal_talk : sprite_0,
});

dialog_character("sans", spr_sans_port_exp1, spr_sans_port_exp1, snd_dialog_sans, {
	def : spr_sans_port_exp1,
	def_talk : spr_sans_port_exp1,
	half: spr_sans_port_exp2,
	half_talk : spr_sans_port_exp2,
	closed: spr_sans_port_exp3,
	closed_talk : spr_sans_port_exp3,
});
#endregion

depth_sort_set_layer("depth");
instance_create_depth(0, 0, 0, obj_game);




room_goto_next();