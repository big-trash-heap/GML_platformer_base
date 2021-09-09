
//
self.ph_speed_x = 3 * (keyboard_check(ord("D")) - keyboard_check(ord("A")));
//self.ph_speed_y = 3 * (keyboard_check(ord("W")) - keyboard_check(ord("S")));

//
if (!self.ph_state_gravity) {
	
	//
	if (keyboard_check_pressed(vk_space)) {
		
		ph_set_speed_y_jump(200); 
		self.ph_state_gravity = true;
	}
	else 
	if (keyboard_check(ord("S"))) {
		
		if (!place_meeting_flags(self.x, self.y + 1)) {
		
			self.y += 2;
			self.ph_state_gravity = true;
		}
	}
}

//
event_inherited();
