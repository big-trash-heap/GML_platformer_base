

#region modify

//					f = function(value, index, data)
/// @function		apiArrMap(array, f, [data]);
function apiArrMap(_array, _f, _data) {
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) 
		array_set(_array, _i, _f(_array[_i], _i, _data));
}

//					f = function(value, index, data)
/// @function		apiArrFilter(array, f, [data]);
function apiArrFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
    if (_size > 0) {
		
		var _count = 0;
		do {
			
			_size -= 1;
			if (_f(_array[_size], _size, _data)) {
				
				array_delete(_array, _size + 1, _count);
				_count = 0;
			}
			else {

				_count += 1;
			}
		} until (_size == 0);
		array_delete(_array, 0, _count);
    }
}

#endregion

#region build

//					f = function(value, index, data)
/// @function		apiArrBulMap(array, f, [data]);
function apiArrBulMap(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = array_create(_size);
	
	for (var _i = 0; _i < _size; ++_i) 
		array_set(_arrayBul, _i, _f(_array[_i], _i, _data));
	
	return _arrayBul;
}

//					f = function(value, index, data)
/// @function		apiArrBulFilter(array, f, [data]);
function apiArrBulFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = [];
    
	if (_size > 0) {
		
        var _i = 0, _value;
        do {
			
            _value = _array[_i];
            if (_f(_value, _i, _data)) array_push(_arrayBul, _value);
        } until (++_i == _size);
    }
    
	return _arrayBul;
}

#endregion

#region other

//					f = function(value, index, data)
/// @function		apiArrCall(array, f, [data]);
function apiArrCall(_array, _f, _data) {
	
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) 
		_f(_array[_i], _i, _data);
}

#endregion

