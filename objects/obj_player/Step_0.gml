var hSpeedGoal = 0;
var onGround=instance_place(x,y+5,obj_wall);


if (keyboard_check(vk_space))
	vspeed += 0.3;
else
	vspeed += 0.8;

if (onGround)
	vspeed = 0;

if (jumping){
	jumpTimer--;
	if (keyboard_check(vk_space) && jumpTimer > 0)
		vspeed = -10;
	else
		jumping = false;
}
if (keyboard_check(vk_right))
{
	image_xscale = 1;
	hSpeedGoal = 10;
	if (hspeed < 0)
		hspeed = 0;	
	sprite_index = spr_player_walk;
	hspeed = lerp(hspeed,hSpeedGoal,0.3);
}
else if (keyboard_check(vk_left))
{
	image_xscale = -1;
	if (hspeed > 0)
		hspeed = 0;
	hSpeedGoal = -10;
	sprite_index = spr_player_walk;
	hspeed = lerp(hspeed,hSpeedGoal,0.3);
}
else{
	hSpeedGoal = 0;
	//hspeed = 0;
	image_index = spr_player_idle;
	hspeed = lerp(hspeed,hSpeedGoal,0.6);
}
if (onGround && keyboard_check_pressed(vk_space)){
	jumping = true;
	jumpTimer = room_speed * 0.4;
	vspeed = -10;
	audio_play_sound(snd_alert,1,false);
}




if (abs(hspeed-hSpeedGoal) < 0.001)
	hspeed = hSpeedGoal;



if (instance_place(x+hspeed,y+vspeed,obj_wall))
{
	hspeed = 0;
	if (instance_place(x+hspeed,y+vspeed,obj_wall))
	{
		vspeed = 0;
	}
}

if (instance_place(x,y,obj_door)){
	//global.points++;
	var next = room_next(room);
	if (next != -1)
		room_goto(next);
}

