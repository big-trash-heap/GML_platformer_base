

/*
	Данные функции являются обёрткой над обычными буферами
	
	Их цель предоставить интерфейс, сигнатура которого,
	подчёркивает их задачу
	
	Задачей данного интерфейса является накопление текста
	и возврат его в виде строки
	
	Кодировка UTF8
*/

/// @param			[size]
function apiBufTxtCreate(_size=128) {
	return buffer_create(_size, buffer_grow, 1);
}

/// @function		apiBufTxtAppend(buffer, string);
function apiBufTxtAppend(_buffer, _string) {
	buffer_write(_buffer, buffer_text, _string);
}

/// @function		apiBufTxtPush(buffer, ...strings);
function apiBufTxtPush(_buffer) {
	
	var _argSize = argument_count;
	for (var _i = 1; _i < _argSize; ++_i) 
		buffer_write(_buffer, buffer_text, argument[_i]);
}

/// @description	Возвращает строку записанную в буфере
//
/// @param			buffer
function apiBufTxtRead(_buffer) {
	
	var _anchor = buffer_tell(_buffer);
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_seek(_buffer, buffer_seek_start, _anchor);
	return _string;
}

/// @function		apiBufTxtClear(buffer, [newsize]);
/// @description	Производит отчистку буферу
//					и изменяет его размер если он был указан
//					Размер может быть изменён, 
//					только в меньшую сторону
function apiBufTxtClear(_buffer, _size) {
	
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	if (!is_undefined(_size) and buffer_get_size(_buffer) > _size)
		buffer_resize(_buffer, _size);
}

/// @description	Удаляет буфер, а так же возвращает
//					строку записанную в нём
//
/// @param			buffer
function apiBufTxtFree(_buffer) {
	
	var _string = apiBufTxtRead(_buffer);
	buffer_delete(_buffer);
	return _string;
}

