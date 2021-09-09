

#macro PH_COLLS_OBJECT_MASK_TYPECOUNT		32
#macro PH_COLLS_OBJECT_MASK_PR_ALLFLAGS	    ( (1 << PH_COLLS_OBJECT_MASK_TYPECOUNT) - 1 )
#macro PH_COLLS_OBJECT_MASK_PR_SOLID		(1 << 0)
#macro PH_COLLS_OBJECT_MASK_PR_SOFT			(1 << 1)


#region collisions-flags

/// @function			place_meeting_flags(x, y, [flags=self.flags], [handler=default]);
function place_meeting_flags(_x, _y, _flags=self.ph_colls_obj_flags_in, _handler=__cb_obj_flags) {
	
	return place_meeting_ext(_x, _y, PH_COLLS_OBJECT, _handler, _flags);
}

/// @function			place_meeting_flags_list(x, y, object, list, [ordered=false], [flags=self.flags], [handler=default]);
function place_meeting_flags_list(_x, _y, _list, _ordered=false, _flags=self.ph_colls_obj_flags_in, _handler=__cb_obj_flags) {
	
	return place_meeting_ext_list(_x, _y, PH_COLLS_OBJECT, _handler, _flags, _list, _ordered);
}

#endregion


#region __callback

function __cb_obj_flags(_inst, _flags) {
	
	if (_inst.ph_colls_obj_flags == PH_COLLS_OBJECT_MASK_PR_SOFT) return false;
	return (_inst.ph_colls_enable && _inst.ph_colls_obj_flags & _flags);
}

function __cb_obj_flags_y(_inst, _flags) {
	
	if (_inst.ph_colls_enable && _inst.ph_colls_obj_flags & _flags) {
		
		if (_inst.ph_colls_obj_flags == PH_COLLS_OBJECT_MASK_PR_SOFT) {
			
			var _speed = GHash.y2 - GHash.y1;
			
			if (_speed > 0 && self.bbox_bottom < _inst.bbox_top + 1) {
				
				return (place_meeting(GHash.x1, GHash.y1, _inst) != noone);
			}
			return false;
		}
		return true;
	}
	return false;
}

#endregion

#region __setHash

function __setHash_points(x1, y1, x2, y2) {
	
	with (GHash) {
		
		self.x1 = x1;
		self.y1 = y1;
		self.x2 = x2;
		self.y2 = y2;
	}
}

#endregion

