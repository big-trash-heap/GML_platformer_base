

#region simple

/// @function		apiFTextWrite(filename, string, [append=false]);
function apiFTextWrite(_filename, _string, _append=false) {
	
	var _file = (_append ? file_text_open_append(_filename) : file_text_open_write(_filename));
	file_text_write_string(_file, _string);
	file_text_close(_file);
}

/// @param			filename
function apiFTextRead(_filename) {
	
	var _file = file_text_open_read(_filename);
	if (_file == -1) {
		
		file_text_close(_filename);
		return undefined;
	}
	
	var _textbuf = apiBufTxtCreate();
	
	while (!file_text_eof(_file))
		apiBufTxtAppend(_textbuf, file_text_readln(_file));
	
	file_text_close(_file);
	return apiBufTxtFree(_textbuf);
}

#endregion

#region buffer

/// @function		apiFTextBufWrite(filename, string);
function apiFTextBufWrite(_filename, _string) {
	
	var _textbuf = apiBufTxtCreate(string_byte_length(_string));
	apiBufTxtAppend(_textbuf, _string);
	buffer_save(_textbuf, _filename);
	buffer_delete(_textbuf);
}

/// @param			filename
function apiFTextBufRead(_filename) {
	
	var _textbuf = buffer_load(_filename);
	if (_textbuf == -1) return undefined;
	return apiBufTxtFree(_textbuf);
}

#endregion

