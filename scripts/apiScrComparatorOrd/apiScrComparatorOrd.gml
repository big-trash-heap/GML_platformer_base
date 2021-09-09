

/*
	Сравнение объектов, с возможностью отсортировать их в порядке (Ord)
	Можно использовать например для функции array_sort
*/

#macro API_COMP_LT	-1	// what < with
#macro API_COMP_EQ	0  	// what = with
#macro API_COMP_GT	1	// what > with

#region basic

/// @function		apiCompOrdNum(what, with);
function apiCompOrdNum(_what, _with) {
	
	/*
		apiCompOrdNum(2.0000242, 2.0000242) -> API_COMP_EQ
		apiCompOrdNum(5, 5)                 -> API_COMP_EQ
		
		apiCompOrdNum(2.0000242, 2.0000243) -> API_COMP_LT
		apiCompOrdNum(2, 5)                 -> API_COMP_LT
		
		apiCompOrdNum(2.0000243, 2.0000242) -> API_COMP_GT
		apiCompOrdNum(5, 2)                 -> API_COMP_GT
	*/
	
	return sign(_what - _with);
}

/// @function		apiCompOrdStr(what, with);
/// @description	Лексикографическое сравнение строк
function apiCompOrdStr(_what, _with) {

	/*
		apiCompOrdStr("aa", "aa") -> API_COMP_EQ
		apiCompOrdStr("", "")     -> API_COMP_EQ
		
		apiCompOrdStr("aa", "ab") -> API_COMP_LT
		apiCompOrdStr("a", "ab")  -> API_COMP_LT
		apiCompOrdStr("", "ab")   -> API_COMP_LT
		apiCompOrdStr("ab", "b")  -> API_COMP_LT
		
		apiCompOrdStr("2", "1")   -> API_COMP_GT
		apiCompOrdStr("2", "11")  -> API_COMP_GT
		apiCompOrdStr("2", "")    -> API_COMP_GT
		apiCompOrdStr("b", "ab")  -> API_COMP_GT
	*/
	
	var _sizeWhat = string_length(_what);
	var _sizeWith = string_length(_with);
	
	var _sign, _j = min(_sizeWhat, _sizeWith);
	for (var _i = 1; _i <= _j; ++_i) {
		
		_sign = sign(string_ord_at(_what, _i) - string_ord_at(_with, _i));
		if (_sign != 0) return _sign;
	}
	
	return sign(_sizeWhat - _sizeWith);
}

/// @function		apiCompOrdNS(what, with);
/// @description	Комбинация apiCompOrdNum и apiCompOrdStr
//					Числа по отношению к строкам, расцениваются
//					как меньшее значение
function apiCompOrdNS(_what, _with) {
	if (is_string(_what)) {
		if (is_string(_with)) {
			return apiCompOrdStr(_what, _with);
		}
		return API_COMP_GT;
	}
	if (is_string(_with)) return API_COMP_LT;
	return sign(_what - _with);
}

#endregion

