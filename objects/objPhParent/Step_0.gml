/// @description move

#region save-speed

self.ph_state_prev_speed_x = self.ph_speed_x;
self.ph_state_prev_speed_y = self.ph_speed_y;

#endregion

#region reset

self.ph_state_collision_x = false;
self.ph_state_collision_y = false;

#endregion

#region collision enable
if (self.ph_colls_enable) {
	
	#region move_x
	
	if (self.ph_speed_x != 0) {
		
		if (magCollsStepW(self.x, self.y, PH_COLLS_OBJECT, 
			self.ph_speed_x, __cb_obj_flags, self.ph_colls_obj_flags_in)) {
			
			self.ph_state_collision_x = true;		
		}
		
		self.x += global.magCollsDist;
		
		if (place_meeting_flags(x, y)) {
			
			self.x -= sign(self.ph_speed_x);
		}
		
		if (self.ph_colls_gravity_enable) {
			
			self.ph_state_gravity =
				(self.ph_speed_y < 0) ||
				(place_meeting_flags(self.x, self.y + 1, _, __cb_obj_flags_y) == noone);
			
			if (!self.ph_state_gravity) {
				
				if (self.ph_speed_y != 0) {
					
					self.ph_state_collision_y = true;
				}
				
				self.ph_speed_y = 0;
			}
		}
	}
	
	#endregion
	
	#region move_y
	
	__setHash_points(self.x, self.y, _, self.y + 1);
	
	if (self.ph_state_gravity) {
		
		if (self.ph_colls_gravity_enable)
			self.ph_speed_y = min(self.ph_speed_y + global.phGravityAcl, global.phGravityMax);
		
		__setHash_points(self.x, self.y, _, self.y + self.ph_speed_y);
		self.ph_state_collision_y =
			magCollsStepH(self.x, self.y, PH_COLLS_OBJECT,
				self.ph_speed_y, __cb_obj_flags_y, self.ph_colls_obj_flags_in);
		
		self.y += global.magCollsDist;
		var _sign = sign(self.ph_speed_y);
		
		if (self.ph_colls_gravity_enable && self.ph_state_collision_y) {
			
			if (self.ph_speed_y > 0) {
				
				self.ph_state_gravity = false;
				self.y = ceil(self.y);
			}
			
			self.ph_speed_y = 0;
		}
		
		if (place_meeting_flags(self.x, self.y)) {
			
			self.y -= _sign;
		}
		
	}
	
	#endregion
	
}
#endregion

#region collision disable
else {
	
	#region move_x
	
	self.x += self.ph_speed_x;
	
	#endregion
	
	#region move_y
	
	if (self.ph_colls_gravity_enable)
		self.ph_speed_y = min(self.ph_speed_y + global.phGravityAcl, global.phGravityMax);
	
	self.y += self.ph_speed_y;
	
	#endregion
}
#endregion
