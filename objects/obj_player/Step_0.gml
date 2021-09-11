
//
var _key_x = (keyboard_check(ord("D")) - keyboard_check(ord("A")));

//
if (_key_x != 0) {
	
	if (_key_x == -1) {
		
		self.ph_speed_x = max(-3, self.ph_speed_x - 0.3);
	}
	else {
		
		self.ph_speed_x = min(3, self.ph_speed_x + 0.3);
	}
}
else {
	
	self.ph_speed_x = sign(self.ph_speed_x) * max(0, abs(self.ph_speed_x) - 0.3);
}

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
