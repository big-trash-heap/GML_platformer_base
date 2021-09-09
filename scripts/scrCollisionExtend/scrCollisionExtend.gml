

#region collisions-ext

/// @function			place_meeting_ext(x, y, object, filter, [data]);
function place_meeting_ext(_x, _y, _object, _filter, _data) {
	
	ds_list_clear(global.__ph_list);
	var _j = instance_place_list(_x, _y, _object, global.__ph_list, false);
	if (_j) {
		
		var _i = 0, _inst;
		do {
			
			_inst = global.__ph_list[| _i];
			if (_filter(_inst, _data)) return _inst;
		} until (++_i == _j);
	}
	return noone;
}

/// @function			place_meeting_ext_list(x, y, object, filter, data, list, [ordered=false]);
function place_meeting_ext_list(_x, _y, _object, _filter, _data, _list, _ordered=false) {
	
	var _i;
	if (is_undefined(_list)) {
		
		_list = global.__ph_list;
		ds_list_clear(_list);
		
		_i = 0;
	}
	else {
		
		_i = ds_list_size(_list);
	}
	
	var _j = instance_place_list(_x, _y, _object, _list, _ordered);
	if (_j) {
		
		var _inst; _j += _i;
		var _p = _i;
		var _k = _p;
		
		while (_i < _j) {
				
			_inst = _list[| _i++];
			if (_filter(_inst, _data)) _list[| _k++] = _inst;
		}
		
		apiDListResize(_list, _k);
		return (_k - _p);
	}
	return 0;
}

#endregion

