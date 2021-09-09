

#region toString

/*
	Предназначенно для отладки
*/

/// @function		apiTStrBuffer(buffer, [bytesize], [bytestart], [metainfo]);
/// @description	Генерирует строку, где каждый байт буфера
//					будет представлен в виде числа в HEX (шестнадцатеричном) формате
//					
/// @param			buffer
/// @param			[bytesize] - количество байтов, которые нужно отобразить
/// @param			[bytestart] - байт с которого нужно начать отображение
/// @param			[metainfo] - нужно ли отображать мета информацию,
//						или только последовательность байтов
function apiTStrBuffer(_buffer, _j, _i, _meta=true) {
	
	/*
		u8 = buffer_u8
		buffer <32:u8, 255:u8, 9:u8> -> <Buffer 20 FF 09>
	*/
	
	var _size   = buffer_get_size(_buffer);
	var _string = (_meta ? "<Buffer" : "");
	
	if (is_undefined(_i)) {

		_i = 0;
	} 
	else
	if (_meta) {
		
		_string += " start of " + string(_i) + " |";
	}
	
	_j = (is_undefined(_j) ? -1 : _i + _j);
	for (; _i < _size; _i += 1) {
		
		if (_i == _j) {
			
			if (_meta) _string += " | ...bytes " + string(_size - _i);
			break;
		}
		
		_string += " ";
		_string += apiTStrInt(buffer_peek(_buffer, _i, buffer_u8), _, 2);
	}
	return (_meta ? _string + ">" : string_delete(_string, 1, 1));
}

#endregion

