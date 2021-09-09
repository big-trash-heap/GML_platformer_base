

/// @function		apiStrReplace(substring, string, index, count);
function apiStrReplace(_substring, _string, _index, _count) {
	return (
		string_copy(_string, 1, _index - 1) +
		_substring +
		string_delete(_string, 1, _index + _count - 1)
	);
}

/// @function		apiStrFindBalance(string, left_ord, right_ord, [index=1]);
/// @description	Находит балансирующий символ в строке от указанного
function apiStrFindBalance(_string, _leftOrd, _rightOrd, _index=1) {
	
	var _type = string_ord_at(_string, _index), _limit;
	if (_type == _leftOrd) {
		
		_type = 1;
		_limit = string_length(_string) + 1;
	}
	else
	if (_type == _rightOrd) {
		
		_type     = _leftOrd;
		_leftOrd  = _rightOrd;
		_rightOrd = _type;
		
		_type = -1;
		_limit = 0;
	}
	else {
		return 0;
	}
	
	_index += _type;
	var _ord, _count = 1;
	while (_index != _limit) {
			
		_ord = string_ord_at(_string, _index);
		if (_ord == _leftOrd)
			_count += 1;
		else
		if (_ord == _rightOrd) {
				
			if (_count == 1) return _index;
			_count -= 1;
		}
			
		_index += _type;
	}
	return 0;
}

