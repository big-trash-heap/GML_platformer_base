

#region modify

//					f = f(struct, key, data)
/// @function		apiStructForEach(struct, f, [data]);
function apiStructForeach(_struct, _f, _data) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
    for (var _i = 0; _i < _size; ++_i)
        _f(_struct, _keys[_i], _data);
	
}

//					f = f(struct, key, data)
/// @function		apiStructFind(struct, f, [data]);
function apiStructFind(_struct, _f, _data) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
    for (var _i = 0; _i < _size; ++_i)
        if (_f(_struct, _keys[_i], _data)) return _keys[_i];
    
    return undefined;
}

#endregion

