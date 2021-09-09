
//
self.ph_colls_obj_flags = (1 << self.image_index);

//
debug {
	
	self.visible = true;
	if (self.object_index != objCollsObj) {
		
		show_error("Не наследуемое событие: objCollsObj.create (" 
			+ object_get_name(self.object_index) + ")", true);
	}
	
	if (self.image_index >= sprite_get_number(self.sprite_index)
		|| self.image_index < 0) {
		
		show_error("Не корректный image_index (" 
			+ object_get_name(self.object_index) + ")", true);
	}
}

