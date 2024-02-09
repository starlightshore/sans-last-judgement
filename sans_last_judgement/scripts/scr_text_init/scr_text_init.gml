global.__text_data = {
	color : {},
	font : {},
	sound : {},
	command : {},
	silent : " \n\t",
	delay : {},
	gain : 1
}

#region in-text command functions
function __text_init_func(name_or_array, func) {
	__text_add_command_type(name_or_array, "init", func);
}

function __text_type_func(name_or_array, func) {
	__text_add_command_type(name_or_array, "type", func);
}

function __text_draw_func(name_or_array, func) {
	__text_add_command_type(name_or_array, "draw", func);
}

function __text_refresh_func(name_or_array, func) {
	__text_add_command_type(name_or_array, "refresh", func);
}

function __text_transform_effect(name_or_array, func) {
	__text_add_command_type(name_or_array, "transform", func);
}

function __text_render_effect(name_or_array, func) {
	__text_add_command_type(name_or_array, "render", func);
}

function __text_add_command_type(name_or_array, type, value) {
	static addCommand = function(name, type, value, removable) {
		var command = global.__text_data.command[$ name];
		if (command = undefined) {
			command = {removable: true};
			global.__text_data.command[$ name] = command;
		}
		command.removable &= removable; //a command is removable only if every type is removable
		command[$ type] = value;
	}
	
	var removable = (type = "variable" || type = "init");
	if is_array(name_or_array) {
		for (var i=0; i<array_length(name_or_array); i++) {
			addCommand(name_or_array[i], type, value, removable);
		}
	} else {
		addCommand(name_or_array, type, value, removable);
	}
}
#endregion

#region formatting
#region color
__text_draw_func(["colour", "color", "col", "c"], function(inst, param) {
	var col = global.__text_data.color[$ param[0]] ?? c_white;
	draw_set_color(col);
});

__text_draw_func(["/colour", "/color", "/col", "/c"], function(inst) {
	draw_set_color(inst.defaultColor);
});
#endregion

#region size
__text_draw_func(["size", "scale", "scl"], function(inst, param) {
	var scl = real(param[0]);
	inst.draw_set_xscale(scl);
	inst.draw_set_yscale(scl);
});
__text_refresh_func(["size", "scale", "scl"], function(inst, param) {
	var scl = real(param[0]);
	inst.refresh_set_xscale(scl);
	inst.refresh_set_yscale(scl);
});
__text_draw_func(["/size", "/scale", "/scl"], function(inst) {
	inst.draw_set_xscale(1);
	inst.draw_set_yscale(1);
});
__text_refresh_func(["/size", "/scale", "/scl"], function(inst) {
	inst.refresh_set_xscale(1);
	inst.refresh_set_yscale(1);
});
#endregion

#region xsize
__text_draw_func(["xsize", "xscale", "xscl"], function(inst, param) {
	inst.draw_set_xscale(real(param[0]));
});
__text_refresh_func(["xsize", "xscale", "xscl"], function(inst, param) {
	inst.refresh_set_xscale(real(param[0]));
});
__text_draw_func(["/xsize", "/xscale", "/xscl"], function(inst) {
	inst.draw_set_xscale(1);
});
__text_refresh_func(["/xsize", "/xscale", "/xscl"], function(inst) {
	inst.refresh_set_xscale(1);
});
#endregion

#region ysize
__text_draw_func(["ysize", "yscale", "yscl"], function(inst, param) {
	inst.draw_set_yscale(real(param[0]));
});
__text_refresh_func(["ysize", "yscale", "yscl"], function(inst, param) {
	inst.refresh_set_yscale(real(param[0]));
});
__text_draw_func(["/ysize", "/yscale", "/yscl"], function(inst) {
	inst.draw_set_yscale(1);
});
__text_refresh_func(["/ysize", "/yscale", "/yscl"], function(inst) {
	inst.refresh_set_yscale(1);
});
#endregion

#region font
var fontFunc = function(inst, param) {
	var fn = global.__text_data.font[$ param[0]] ?? draw_get_font();
	draw_set_font(fn);
}
__text_draw_func("font", fontFunc);
__text_refresh_func("font", fontFunc);

var fontEndFunc = function(inst) {
	draw_set_font(inst.defaultFont);
}
__text_draw_func("/font", fontEndFunc);
__text_refresh_func("/font", fontEndFunc);
#endregion
#endregion

#region typing options
__text_type_func(["sound", "snd"], function(inst, param) {
	inst.typeSound = global.__text_data.sound[$ param[0]];
});

__text_type_func(["/sound", "/snd"], function(inst) {
	inst.typeSound = inst.defaultTypeSound;
});

__text_type_func(["speed", "spd"], function(inst, param) {
	inst.typeSpeed = game_get_speed(gamespeed_fps) / real(param[0]);
});

__text_type_func(["/speed", "/spd"], function(inst) {
	inst.typeSpeed = inst.defaultTypeSpeed;
});
#endregion

#region transform effects
__text_transform_effect("shake", function(inst, trans) {
	trans.x += irandom_range(-1, 1);
	trans.y += irandom_range(-1, 1);
});

__text_transform_effect("wave", function(inst, trans) {
	trans.y += sin(trans.x * 0.1 - current_time * 0.005) * 2;
});

__text_transform_effect("scared", function(inst, trans) {
	if (irandom(200) = 0) trans.y += irandom(1) * 2 - 1;
});

__text_transform_effect(["/shake", "/wave", "/scared"], "reset");
#endregion

#region random
__text_type_func("wait", function(inst, param) {
	inst.wait_seconds(real(param[0]));
});

__text_draw_func(["sprite", "spr"], function(inst, param) {
	var spr = asset_get_index(param[0]);
	if (spr = -1) return;
	var spd = sprite_get_speed(spr);
	if (sprite_get_speed_type(spr) = spritespeed_framespersecond) spd /= game_get_speed(gamespeed_fps);
	var subimg = (spd * inst.get_type_frame()) % sprite_get_number(spr);
	var _x = sprite_get_xoffset(spr);
	var _y = sprite_get_yoffset(spr) - sprite_get_height(spr) * 0.5;
	var trans = inst.draw_get_transform(_x, _y);
	draw_sprite_ext(spr, subimg, trans.x, trans.y, trans.xscale, trans.yscale, trans.angle, c_white, 1);
	inst.draw_add_width(sprite_get_width(spr));
	//inst.draw_add_height(sprite_get_height(spr));
});
__text_type_func(["sprite", "spr"], function(inst) {
	inst.wait(1);
	inst.play_type_sound();
});
__text_refresh_func(["sprite", "spr"], function(inst, param) {
	var spr = asset_get_index(param[0]);
	if (spr = -1) return;
	inst.refresh_add_width(sprite_get_width(spr));
	inst.refresh_add_height(sprite_get_height(spr));
})
#endregion