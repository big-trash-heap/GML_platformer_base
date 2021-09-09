

/*
	Настройки работы функций
	(смотри в scrMagicCollisionsToolsMove)
*/

// Общие настройки
														// сохранения id объекта, с которым было обнаруженно столкновение в последний раз
														// записывается global.magCollsId
#macro MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID	false

// Настройки magCollsJumpLine
														// проверка ошибочных ситуаций
														// из-за погрешности collision_line, иногда результат magCollsJumpLine оказывается неверным
														// эта настройка может решить эту проблему, но зачастую это совсем не нужно
#macro MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_FIXANGLE	false
														
														// сохранения угла
														// записывается в global.magCollsDir
#macro MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETANGLE	false


#region PREPROCESSOR

// инициализация переменных

if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
	global.magCollsId = noone;
}

if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETANGLE) {
	
	global.magCollsDir = 0;
}

#endregion

/*
	Некоторые шаблонные реализации основанные на magCollsJump
	
	Все функции возвращают true, при наличии столкновение и false при его отсутствие
	Так же, они запишут последнею "свободную" скорость в переменную global.magCollsDist
	(под свободной я подразумеваю, скорость при которой столкновения нету)
*/

#region line

/// @function		magCollsJumpLine(x1, y1, x2, y2, obj, [prec=false], [notme=false], [accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY]);
function magCollsJumpLine(_x1, _y1, _x2, _y2, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check = method(global.__magCollsSampleObject,
		function(_speed, _object) {
			
			_object = collision_line(
				self._x1, self._y1,
				self._x1 + lengthdir_x(_speed, self._dir),
					self._y1 + lengthdir_y(_speed, self._dir),
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsId = _object;
			}
			return _object;
		});
		
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsId = noone;
	}
	
	var _dir = point_direction(_x1, _y1, _x2, _y2);
	
	if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETANGLE) {
		
		global.magCollsDir = _dir;
	}
	
	global.__magCollsSampleObject._x1    = _x1;
	global.__magCollsSampleObject._y1    = _y1;
	global.__magCollsSampleObject._dir   = _dir;
	global.__magCollsSampleObject._prec  = _prec;
	global.__magCollsSampleObject._notme = _notme;
	
	_x2 = point_distance(_x1, _y1, _x2, _y2);
	_y2 = magCollsJump(_x2, _check, _obj, _accuracy);
	
	if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_FIXANGLE) {
		
		if (_y2) {
			
			_x1 = _x1 + lengthdir_x(global.magCollsDist, _dir);
			_y1 = _y1 + lengthdir_y(global.magCollsDist, _dir);
			
			if (!collision_circle(_x1, _y1, 1.7 + _accuracy, _obj, _prec, _notme)) {
				
				global.magCollsDist = _x2;
				
				if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
					global.magCollsId = noone;
				}
				
				return false;
			}
		}
	}
	
	return _y2;
}

#endregion

#region rectangle

/// @function		magCollsJumpRectW(x1, y1, y2, width, obj, [prec=false], [notme=false], [accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY]);
function magCollsJumpRectW(_x1, _y1, _y2, _width, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check_xp = method(global.__magCollsSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1,
				self._x1 + _speed, self._z,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsId = _object;
			}
			return _object;
		});
	
	static _check_xm = method(global.__magCollsSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1 - _speed, self._y1,
				self._x1, self._z,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsId = _object;
			}
			return _object;
		});
	
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsId = noone;
	}
	
	global.__magCollsSampleObject._x1    = _x1;
	global.__magCollsSampleObject._y1    = _y1;
	global.__magCollsSampleObject._z     = _y2;
	global.__magCollsSampleObject._prec  = _prec;
	global.__magCollsSampleObject._notme = _notme;
	
	if (sign(_width) == -1) {
		
		_y1 = magCollsJump(-_width, _check_xm, _obj, _accuracy);
		global.magCollsDist = -global.magCollsDist;
	}
	else {
		
		_y1 = magCollsJump(_width, _check_xp, _obj, _accuracy);
	}
	
	return _y1;
}

/// @function		magCollsJumpRectH(x1, y1, x2, height, obj, [prec=false], [notme=false], [accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY]);
function magCollsJumpRectH(_x1, _y1, _x2, _height, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check_yp = method(global.__magCollsSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1,
				self._z, self._y1 + _speed,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsId = _object;
			}
			return _object;
		});
	
	static _check_ym = method(global.__magCollsSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1 - _speed,
				self._z, self._y1,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsId = _object;
			}
			return _object;
		});
	
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsId = noone;
	}
	
	global.__magCollsSampleObject._x1    = _x1;
	global.__magCollsSampleObject._y1    = _y1;
	global.__magCollsSampleObject._z     = _x2;
	global.__magCollsSampleObject._prec  = _prec;
	global.__magCollsSampleObject._notme = _notme;
	
	if (sign(_height) == -1) {
		
		_y1 = magCollsJump(-_height, _check_ym, _obj, _accuracy);
		global.magCollsDist = -global.magCollsDist;
	}
	else {
		
		_y1 = magCollsJump(_height, _check_yp, _obj, _accuracy);
	}
	
	return _y1;
}

#endregion

#region circle

/// @function		magCollsJumpCircle(x, y, rad, obj, [prec=false], [notme=false], [accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY]);
function magCollsJumpCircle(_x, _y, _rad, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check = method(global.__magCollsSampleObject,
		function(_speed, _object) {
			
			_object = collision_circle(
				self._x1, self._y1,
				_speed, _object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsId = _object;
			}
			return _object;
		});
	
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsId = noone;
	}
	
	global.__magCollsSampleObject._x1    = _x;
	global.__magCollsSampleObject._y1    = _y;
	global.__magCollsSampleObject._z     = _rad;
	global.__magCollsSampleObject._prec  = _prec;
	global.__magCollsSampleObject._notme = _notme;
	
	return magCollsJump(_rad, _check, _obj, _accuracy);
}

#endregion


#region __object

if (!variable_global_exists("__magCollsSampleObject")) {
	
	global.__magCollsSampleObject = {};
}

#endregion

