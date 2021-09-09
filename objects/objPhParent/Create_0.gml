/// @description init

//
self.ph_speed_x = 0;
self.ph_speed_y = 0;

//
self.ph_state_gravity = true;

//
self.ph_state_prev_speed_x = 0;
self.ph_state_prev_speed_y = 0;

//
self.ph_state_collision_x = 0;
self.ph_state_collision_y = 0;

//
debug {
	
	show_debug_message(@"
	Ph " + string(self.id) + @":
		ph_speed_x				: " + string(self.ph_speed_x) + @"
		ph_speed_y				: " + string(self.ph_speed_y) + @"
		ph_colls_obj_flags		: " + string(self.ph_colls_obj_flags) + @"
		ph_colls_obj_flags_in	: " + string(self.ph_colls_obj_flags_in) + @"
		ph_colls_enable			: " + string(self.ph_colls_enable) + @"
");
}

GHash.yy = y;