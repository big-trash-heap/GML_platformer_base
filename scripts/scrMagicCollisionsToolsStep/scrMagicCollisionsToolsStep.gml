
// check = check(inst, data)

/// @function		magCollsStepW(x, y, object, speed, [check], [data]);
function magCollsStepW(_x, _y, _object, _speed, _check, _data) {
	
	static _find_left = function(_left, _inst) {
		
		return min(_left, _inst.bbox_left);
	}
	
	static _find_right = function(_right, _inst) {
		
		return max(_right, _inst.bbox_right);
	}
	
	ds_list_clear(global.__magCollsStepList);
	
	var _size;
	if (_speed < 0) {
		
		_size = collision_rectangle_list(
			self.bbox_left + _speed, self.bbox_top, 
			self.bbox_right, self.bbox_bottom, 
			_object, false, true, global.__magCollsStepList, false);
	}
	else {
		
		_size = collision_rectangle_list(
			self.bbox_left, self.bbox_top, 
			self.bbox_right + _speed, self.bbox_bottom, 
			_object, false, true, global.__magCollsStepList, false);
	}
	
	if (_size) {
		
		var _find_f, _find_v, _inst;
		if (_speed < 0) {
			
			_find_f = _find_right;
			_find_v = -infinity;
		}
		else {
			
			_find_f = _find_left;
			_find_v = infinity;
		}
		
		if (!is_undefined(_check)) {
			
			do {
				_inst = global.__magCollsStepList[| --_size];
				if (_check(_inst, _data)) _find_v = _find_f(_find_v, _inst);
			} until (_size == 0);
			
			if (!is_infinity(_find_v)) {
				
				if (_speed < 0) 
					global.magCollsDist = (_find_v - self.bbox_left + 1);
				else
					global.magCollsDist = (_find_v - self.bbox_right - 1);
				
				return true;
			}
		}
		else {
			
			do {
				_find_v = _find_f(_find_v, global.__magCollsStepList[| --_size]);
			} until (_size == 0);
			
			if (_speed < 0) 
				global.magCollsDist = (_find_v - self.bbox_left + 1);
			else
				global.magCollsDist = (_find_v - self.bbox_right - 1);
			
			return true;
		}
	}
	
	global.magCollsDist = _speed;
	return false;
}

/// @function		magCollsStepH(x, y, object, speed, [check], [data]);
function magCollsStepH(_x, _y, _object, _speed, _check, _data) {
	
	static _find_top = function(_top, _inst) {
		
		return min(_top, _inst.bbox_top);
	}
	
	static _find_bottom = function(_bottom, _inst) {
		
		return max(_bottom, _inst.bbox_bottom);
	}
	
	ds_list_clear(global.__magCollsStepList);
	
	var _size;
	if (_speed < 0) {
		
		_size = collision_rectangle_list(
			self.bbox_left, self.bbox_top + _speed, 
			self.bbox_right, self.bbox_bottom, 
			_object, false, true, global.__magCollsStepList, false);
	}
	else {
		
		_size = collision_rectangle_list(
			self.bbox_left, self.bbox_top, 
			self.bbox_right, self.bbox_bottom + _speed, 
			_object, false, true, global.__magCollsStepList, false);
	}
	
	if (_size) {
		
		var _find_f, _find_v, _inst;
		if (_speed < 0) {
			
			_find_f = _find_bottom;
			_find_v = -infinity;
		}
		else {
			
			_find_f = _find_top;
			_find_v = infinity;
		}
		
		if (!is_undefined(_check)) {
			
			do {
				_inst = global.__magCollsStepList[| --_size];
				if (_check(_inst, _data)) _find_v = _find_f(_find_v, _inst);
			} until (_size == 0);
			
			if (!is_infinity(_find_v)) {
				
				if (_speed < 0) 
					global.magCollsDist = (_find_v - self.bbox_top + 1);
				else
					global.magCollsDist = (_find_v - self.bbox_bottom - 1);
				
				return true;
			}
		}
		else {
			
			do {
				_find_v = _find_f(_find_v, global.__magCollsStepList[| --_size]);
			} until (_size == 0);
			
			if (_speed < 0) 
				global.magCollsDist = (_find_v - self.bbox_top + 1);
			else
				global.magCollsDist = (_find_v - self.bbox_bottom - 1);
			
			return true;
		}
	}
	
	global.magCollsDist = _speed;
	return false;
}

#region 

global.__magCollsStepList = ds_list_create();

#endregion
