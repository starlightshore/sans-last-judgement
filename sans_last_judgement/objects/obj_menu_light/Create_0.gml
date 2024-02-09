/// @desc
text_name	= "Chara";
text_lv		= "LV"
text_hp		= "HP"
text_money	= "g"

value_lv	= "19"
value_hp	= "92"
value_hp_max= "92"
value_money	= "2"

//TODO: add a check if item is empty
//add a check if cell options are empty
item_lock	= true;
cell_lock	= true;

menu_list	= [
	"ITEM",
	"STAT",
	"CELL"
]
menu_total	= array_length(menu_list);
menu_select = 0;
menu_level	= 0;

item_list	= [
	"test item"
]
item_total	= array_length(item_list);
item_select = 0;

item_choice	= [
	"USE",
	"INFO",
	"TOSS"
]
item_choice_total = array_length(item_choice)
item_choice_selection = -1;

at_text = "AT";
df_text = "DF";
exp_text = "EXP"+": ";
next_text = "NEXT"+": ";

value_at = 99;
value_df = 99;
value_weapon_at = 1;
value_weapon_df = 0;
value_exp = 25000;
value_next = 25000;

weapon_text = "WEAPON"+": ";
armor_text = "ARMOR"+": "

weapon = "True Knife";
armor = "Heart Locket";

money_text = "GOLD"+": "

can_input	= false;
alarm[0]	= 1;


destroy = function(){
	obj_player.can_menu = true;
	alarm[1]=1;
}
update_menu_level = function(level){
	menu_level = level;
	//TODO: add sound effect for confirm
}