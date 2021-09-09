
//					f = function(value, index, data)
/// @function		apiDListFilter(array, f, [data]);
function apiDListFilter(_id, _f, _data) {
	
	var _idSize = ds_list_size(_id);
    if (_idSize > 0) {
		
		var _count = 0;
		do {
			
			_idSize -= 1;
			if (_f(_id[| _idSize], _idSize, _data)) {
				
				apiDListDel(_id, _idSize + 1, _count);
				_count = 0;
			}
			else {

				_count += 1;
			}
		} until (_idSize == 0);
		apiDListDel(_id, 0, _count);
    }
}

