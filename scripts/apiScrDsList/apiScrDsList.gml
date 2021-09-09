

#region modify

/// @function		apiDListResize(id, size);
/// @description	Аналог array_resize
function apiDListResize(_id, _size) {
	var _idSize = ds_list_size(_id);
	if (_size > _idSize) {
		
		repeat (_size - _idSize) ds_list_add(_id, 0);
	}
	else {
		
		while (_size != _idSize) ds_list_delete(_id, --_idSize);
	}
}

/// @function		apiDListDel(id, index, count);
/// @description	Аналог array_delete
function apiDListDel(_id, _index, _count) {
	
	var _idSize = ds_list_size(_id);
	var _mSize = _idSize - _index;
	
	_count = min(_count, _mSize);
	if (_count <= 0) exit;
	
	repeat (_mSize - _count) {
		
		_id[| _index] = _id[| _index + _count];
		++_index;
	}
	apiDListResize(_id, _idSize - _count);
}

#endregion

#region build

/// @param			...
/// @description	Строит список из аргументов
function apiDListBul() {
	var _id = ds_list_create();
	var _argSize = argument_count;
	
	for (var _i = 0; _i < _argSize; ++_i)
		ds_list_add(_id, argument[_i]);
	
	return _id;
}

#endregion

#region other

/// @param			id
/// @description	Запишет список в массив
function apiDListToArr(_id) {
	var _idSize = ds_list_size(_id);
	var _array = array_create(_idSize);
	
	for (var _i = 0; _i < _idSize; ++_i) 
		_array[_i] = _id[| _i];
	
	return _array;
}

#endregion

