walkSpeed = 60 * global.dt;
runSpeed =	60 * global.dt;
running = false;
interactDist = 4;
interactList = ds_list_create();

charSprite = char_sprite_create(global.charPlayer);

can_menu = true;
image_blend = c_black;

input = true;
