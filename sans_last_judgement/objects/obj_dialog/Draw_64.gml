var borderLeft = 12;
var borderRight = 12;
var borderTop = 6;

draw_sprite_stretched(spr_textbox_light, textbox_anim, x, y, width, height);

if (!is_undefined(character)) {
	if (textObj.is_finished()) {
		sprite_index = charFace;
	} else {
		sprite_index = charTalk;
	}
}

if (sprite_index > 0) {
	draw_sprite(sprite_index, image_index, x + 25, y + height / 2);
	borderLeft = 50;
}

draw_set_color(color);
draw_set_font(font);

text_set_font(textObj, font);
text_set_wrap(textObj, width - borderLeft - borderRight);
text_draw(textObj, x + borderLeft, y + borderTop);

if (state = "choice") {
	for (var i=0; i<array_length(optionKey); i++) {
		if (i = optionSelected) {
			draw_set_color(c_yellow);
		} else {
			draw_set_color(c_white);
		}
		draw_text(x + borderLeft, x + borderLeft + i * 16, optionText[i])
	}
}