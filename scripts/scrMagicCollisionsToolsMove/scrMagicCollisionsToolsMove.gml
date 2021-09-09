
/*
	Настройки работы функций
	
	Так как эти функции не являются критически важными, а скорее удобным дополнением,
	то я вынес их в "препросессор", а не добавил как переключаемые аргументы
*/

															// первоначальная проверка столкновение, со скоросью 0
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKZERO			false
															
															// первоначальная проверка столкновение, со скоростью равным знаку "скорости"
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN			false
															// использовать ли для этой проверки указанную точность
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN_ACCURACY false

/*
	Данные функции позволяют проверить столкновение симулируя пошаговое движение
	
	В качестве проверки столкновение выступает функция check, которая должна вернуть true/false
	(true - есть столкновение)
	
	Обе функции вернут true при наличии столкновения, и false при его отсутствии
	Так же, они запишут последнею "свободную" скорость в переменную global.magCollsDist
	(под свободной я подразумеваю, скорость при которой столкновения нету)
*/

// check = check(speed, data)

/// @function		magCollsMove_single(speed, accuracy, check, [data]);
function magCollsMove_single(_speed, _accuracy, _check, _data) {
	
	//
	global.magCollsDist = 0;
	
	//
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKZERO) {
	
		if (_check(0, _data)) return true;
	}
	
	//
	if (_speed < 0)
		_accuracy = -_accuracy;
	
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN) {
		if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN_ACCURACY) {
		
			if (_check(_accuracy, _data)) return true;
		}
		else {
			
			if (_check(sign(_speed), _data)) return true;
		}
	}
	
	//
	var _iter = 0;	
	repeat floor(_speed / _accuracy) {
		
		//
		_iter += _accuracy;
		
		//
		if (_check(_iter, _data)) {
			
			global.magCollsDist = _iter - _accuracy;
			return true;
		}
	}
	
	//
	if (_check(_speed, _data)) {
		
		global.magCollsDist = _iter;
		return true;
	}
	
	global.magCollsDist = _speed;
	return false;
}

/// @function		magCollsMove_double(speed, accuracy_micro, accuracy_macro, check, [data]);
/// @description	В качестве шага для проверки столкновения будет использовать accuracy_macro
//					При наличии столкновения, уточнит его с помощью accuracy_micro
function magCollsMove_double(_speed, _accuracyMicro, _accuracyMacro, _check, _data) {
	
	//
	global.magCollsDist = 0;
	
	//
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKZERO) {
	
		if (_check(0, _data)) return true;
	}
	
	//
	if (_speed < 0) {
		
		_accuracyMicro = -_accuracyMicro;
		_accuracyMacro = -_accuracyMacro;
	}
	
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN) {
		if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN_ACCURACY) {
		
			if (_check(_accuracyMicro, _data)) return true;
		}
		else {
			
			if (_check(sign(_speed), _data)) return true;
		}
	}
	
	//
	var _div  = floor(_speed / _accuracyMacro);
	var _iter = 0;
	repeat _div {
		
		//
		_iter += _accuracyMacro;
		
		//
		if (_check(_iter, _data)) {
			
			//
			do {
				_iter -= _accuracyMicro;
			} until (!_check(_iter, _data));
			
			//
			global.magCollsDist = _iter;
			return true;
		}
	}
	
	//
	global.magCollsDist = _iter;
	
	//
	repeat floor((_speed - _div * _accuracyMacro) / _accuracyMicro) {
		
		//
		_iter += _accuracyMicro;
		
		//
		if (_check(_iter, _data)) {
			
			global.magCollsDist = _iter - _accuracyMicro;
			return true;
		}
	}
	
	//
	if (_check(_speed, _data)) {
		
		global.magCollsDist = _iter;
		return true;
	}
	
	global.magCollsDist = _speed;
	return false;
}

