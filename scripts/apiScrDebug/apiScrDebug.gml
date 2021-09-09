

/*
	Набор функций для отладки и тестирования
*/

#region print

/// @function		apiDebugShow(array, [handler]);
/// @description	Конструирует строку из массива,
//					применяя к каждому элементу массива
//					handler
function apiDebugShow(_array, _handler) {
	
	static _handler_def = function(_value) {
		
		return (string(_value) + " ");
	}
	
	if (is_undefined(_handler)) _handler = _handler_def;
	
	var _size = array_length(_array);
	var _text = "";
	
	for (var _i = 0; _i < _size; ++_i)
		_text += _handler(_array[_i]);
	
	return _text;
}

/// @function		apiDebugPrint(...values);
function apiDebugPrint() {
	
	//
	API_MACRO_ARGPACK_OFFS 0;
	API_MACRO_ARGPACK_READ;
	var _text = apiDebugShow(API_MACRO_ARGPACK_GET);
	
	show_debug_message(_text);
	return _text;
}

#endregion

#region assert

/// @function		apiDebugAssert(assert, message);
function apiDebugAssert(_assert, _mess) {
	if (!_assert) {
		
		clipboard_set_text("\"" + _mess + "\"");
		throw ("\n\t" + _mess);
	}
}

#endregion

#region error

/// @param			message
function apiDebugError(_message, _prefix="API-ERROR") {
	show_error(
		_prefix + ": {\n\t" + string(_message) + "\n};", 
		true
	);
}

#endregion
